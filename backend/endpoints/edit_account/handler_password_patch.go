package edit_account

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

// ChangePasswordPatchHandler
// @ID account.change_password.patch
// @Summary Change password
// @Description Change password
// @Tags account
// @Accept json
// @Produce json
// @Param payload body changePasswordRequest true "edit_account.changePasswordRequest"
// @Success 200 {object} changePasswordRequest
// @Failure 400 {object} responder.ErrorResponse
// @Router /account/edit/password [patch]
func ChangePasswordPatchHandler(c *fiber.Ctx) error {
	// * Parse user JWT token
	token := c.Locals("user").(*jwt.Token)
	claims := token.Claims.(*common.UserClaim)

	// * Parse body
	var body changePasswordRequest
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
