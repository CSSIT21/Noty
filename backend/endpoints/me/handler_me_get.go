package me

import (
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"github.com/kamva/mgm/v3"
	"noty-backend/loaders/mongo/models"
	"noty-backend/types/common"
	"noty-backend/types/responder"
)

// MeGetHandler
// @ID me.get
// @Summary Get user information
// @Description List user information
// @Tags me
// @Accept json
// @Produce json
// @Success 200 {object} me.meGetResponse
// @Failure 400 {object} responder.ErrorResponse
// @Router /me/info [get]
func MeGetHandler(c *fiber.Ctx) error {
	// * Parse user JWT token
	token := c.Locals("user").(*jwt.Token)
	claims := token.Claims.(*common.UserClaim)

	user := new(models.User)

	// * Get user information
	if err := mgm.Coll(user).FindByID(*claims.UserId, user); err != nil {
		return &responder.GenericError{
			Message: "Unable to fetch user information",
			Err:     err,
		}
	}

	return c.JSON(&responder.InfoResponse{
		Success: true,
		Data: &meGetResponse{
			UserId:    user.ID.Hex(),
			Firstname: *user.Firstname,
			Lastname:  *user.Lastname,
			Email:     *user.Email,
			PictureId: *user.PictureId,
		},
	})
}
