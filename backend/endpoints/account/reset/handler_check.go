package reset

import (
	"github.com/gofiber/fiber/v2"
	"github.com/kamva/mgm/v3"
	"go.mongodb.org/mongo-driver/bson"
	mongoDriver "go.mongodb.org/mongo-driver/mongo"

	"noty-backend/loaders/mongo/models"
	"noty-backend/types/responder"
	"noty-backend/utils/text"
)

// CheckHandler
// @ID account.reset.check.post
// @Summary Check account token
// @Description Check account token
// @Tags account
// @Accept json
// @Produce json
// @Param payload body verifyRequest true "reset.verifyRequest"
// @Success 200 {object} responder.InfoResponse
// @Failure 400 {object} responder.ErrorResponse
// @Router /account/reset/check [post]
func CheckHandler(c *fiber.Ctx) error {
	// * Parse body
	var body verifyRequest
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

	// * Check account
	if result := mgm.Coll(new(models.User)).FindOne(
		mgm.Ctx(),
		bson.M{
			"email":       body.Email,
			"reset_token": body.Pin,
		},
	); result.Err() == mongoDriver.ErrNoDocuments {
		return &responder.GenericError{
			Message: "Invalid password resetting verification",
		}
	} else if result.Err() != nil {
		return &responder.GenericError{
			Message: "Unable to fetch user account",
			Err:     result.Err(),
		}
	}

	return c.JSON(&responder.InfoResponse{
		Success: true,
		Info:    "Pin verification passed",
	})
}