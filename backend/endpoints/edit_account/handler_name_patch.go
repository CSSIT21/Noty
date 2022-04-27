package edit_account

import (
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"github.com/kamva/mgm/v3"
	"noty-backend/loaders/mongo/models"
	"noty-backend/types/common"
	"noty-backend/types/responder"
)

// EditNamePatchHandler
// @ID account.edit_information.patch
// @Summary Change a name
// @Description Patch account information
// @Tags account
// @Accept json
// @Produce json
// @Param payload body editNameRequest true "edit_account.editNameRequest"
// @Success 200 {object} editNameRequest
// @Failure 400 {object} responder.ErrorResponse
// @Router /account/edit/name [patch]
func EditNamePatchHandler(c *fiber.Ctx) error {
	// * Parse user JWT token
	token := c.Locals("user").(*jwt.Token)
	claims := token.Claims.(*common.UserClaim)

	// * Parse body
	var body editNameRequest
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
