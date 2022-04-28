package me

import (
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"github.com/kamva/mgm/v3"
	"noty-backend/loaders/mongo/models"
	"noty-backend/types/common"
	"noty-backend/types/responder"
	"noty-backend/utils/crypto"
	"noty-backend/utils/text"
)

// MePatchPasswordHandler
// @ID me.change_password.patch
// @Summary Change password
// @Description Change password
// @Tags me
// @Accept json
// @Produce json
// @Param payload body mePatchPasswordRequest true "me.mePatchPasswordRequest"
// @Success 200 {object} responder.InfoResponse
// @Failure 400 {object} responder.ErrorResponse
// @Router /me/edit/password [patch]
func MePatchPasswordHandler(c *fiber.Ctx) error {
	// * Parse user JWT token
	token := c.Locals("user").(*jwt.Token)
	claims := token.Claims.(*common.UserClaim)

	// * Parse body
	var body mePatchPasswordRequest
	if err := c.BodyParser(&body); err != nil {
		return &responder.GenericError{
			Message: "Unable to parse body",
			Err:     err,
		}
	}

	// * Validate body
	if err := text.Validate.Struct(body); err != nil {
		return err
	}

	user := new(models.User)
	// * Find user
	if err := mgm.Coll(user).FindByID(*claims.UserId, user); err != nil {
		return &responder.GenericError{
			Message: "Unable to find the user",
			Err:     err,
		}
	}

	// * Check current password
	if !crypto.ComparePassword(*user.Password, body.CurrentPassword) {
		return &responder.GenericError{
			Message: "Current password is incorrect",
		}
	}

	// * Hash password
	hashedPassword, _ := crypto.HashPassword(body.NewPassword)

	user.Password = &hashedPassword

	// * Update user
	if err := mgm.Coll(user).Update(user); err != nil {
		return &responder.GenericError{
			Message: "Unable to change the password",
			Err:     err,
		}
	}

	return c.JSON(&responder.InfoResponse{
		Success: true,
		Info:    "Update password successful",
	})
}
