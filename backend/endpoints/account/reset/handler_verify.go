package reset

import (
	"github.com/gofiber/fiber/v2"

	"noty-backend/types/responder"
	"noty-backend/utils/mail"
)

// VerifyHandler
// @ID account.reset.verify.post
// @Summary Reset account password
// @Description Reset account password
// @Tags account
// @Accept json
// @Produce json
// @Param payload body resetRequest true "reset.resetRequest"
// @Success 200 {object} responder.InfoResponse
// @Failure 400 {object} responder.ErrorResponse
// @Router /account/reset/send [post]
func VerifyHandler(c *fiber.Ctx) error {
	// * Parse body
	var body resetRequest
	if err := c.BodyParser(&body); err != nil {
		return &responder.GenericError{
			Message: "Unable to parse body",
			Err:     err,
		}
	}

	return mail.SendPasswordResetMail("Thun", "125759", "psn@bsthun.com")
}
