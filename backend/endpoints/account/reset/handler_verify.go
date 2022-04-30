package reset

import (
	"github.com/gofiber/fiber/v2"
	"github.com/kamva/mgm/v3"
	"go.mongodb.org/mongo-driver/bson"
	mongoDriver "go.mongodb.org/mongo-driver/mongo"

	"noty-backend/loaders/mongo/models"
	"noty-backend/types/responder"
	"noty-backend/utils/crypto"
	"noty-backend/utils/text"
)

// VerifyHandler
// @ID account.reset.verify.post
// @Summary Reset account password
// @Description Reset account password
// @Tags account
// @Accept json
// @Produce json
// @Param payload body verifyRequest true "reset.verifyRequest"
// @Success 200 {object} responder.InfoResponse
// @Failure 400 {object} responder.ErrorResponse
// @Router /account/reset/verify [post]
func VerifyHandler(c *fiber.Ctx) error {
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

	// * Hash new password
	password, err := crypto.HashPassword(body.Password)
	if err != nil {
		return &responder.GenericError{
			Message: "Unable to hash the password",
			Err:     err,
		}
	}

	// * Update password
	if result := mgm.Coll(new(models.User)).FindOneAndUpdate(
		mgm.Ctx(),
		bson.M{
			"email":       body.Email,
			"reset_token": body.Pin,
		},
		bson.M{"$set": bson.M{
			"reset_token": nil,
			"password":    password,
		}},
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
		Info:    "Your password reset has been proceed, you can now login to the app",
	})
}
