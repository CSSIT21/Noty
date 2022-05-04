package me

import (
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"github.com/kamva/mgm/v3"
	"noty-backend/loaders/mongo/models"
	"noty-backend/types/common"
	"noty-backend/types/responder"
)

// MePatchNameHandler
// @ID me.edit_information.patch
// @Summary Change a name
// @Description Patch account information
// @Tags me
// @Accept json
// @Produce json
// @Param payload body mePatchNameRequest true "me.mePatchNameRequest"
// @Success 200 {object} responder.InfoResponse
// @Failure 400 {object} responder.ErrorResponse
// @Router /me/edit/name [patch]
func MePatchNameHandler(c *fiber.Ctx) error {
	// * Parse user JWT token
	token := c.Locals("user").(*jwt.Token)
	claims := token.Claims.(*common.UserClaim)

	// * Parse body
	var body mePatchNameRequest
	if err := c.BodyParser(&body); err != nil {
		return &responder.GenericError{
			Message: "Unable to parse body",
			Err:     err,
		}
	}

	user := new(models.User)
	// * Find user
	if err := mgm.Coll(user).FindByID(*claims.UserId, user); err != nil {
		return &responder.GenericError{
			Message: "Unable to find the user",
			Err:     err,
		}
	} else {
		if len(body.Firstname) > 1 {
			user.Firstname = &body.Firstname
		}
		if len(body.Lastname) > 1 {
			user.Lastname = &body.Lastname
		}
	}

	// * Update user
	if err := mgm.Coll(user).Update(user); err != nil {
		return &responder.GenericError{
			Message: "Unable to update the user",
			Err:     err,
		}
	}

	return c.JSON(&responder.InfoResponse{
		Success: true,
		Info:    "Update user information successful",
	})
}
