package me

import (
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"

	"noty-backend/types/common"
	"noty-backend/types/responder"
)

// AvatarPostHandler
// @ID account.avatar.post
// @Summary Update avatar image
// @Description Update avatar image
// @Tags account
// @Accept json
// @Produce json
// @Param image form string true "image"
// @Success 200 {object} loginResponse
// @Failure 400 {object} responder.ErrorResponse
// @Router /me/avatar [post]
func AvatarPostHandler(c *fiber.Ctx) error {
	// * Parse user JWT token
	token := c.Locals("user").(*jwt.Token)
	claims := token.Claims.(*common.UserClaim)

	file, err := c.FormFile("image")
	if err != nil {
		return &responder.GenericError{
			Message: "Unable to parse image file",
			Err:     err,
		}
	}

}
