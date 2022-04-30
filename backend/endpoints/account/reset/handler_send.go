package reset

import (
	"github.com/gofiber/fiber/v2"
	"github.com/kamva/mgm/v3"
	"go.mongodb.org/mongo-driver/bson"
	mongoDriver "go.mongodb.org/mongo-driver/mongo"

	"noty-backend/loaders/mongo/models"
	"noty-backend/types/responder"
	"noty-backend/utils/mail"
	"noty-backend/utils/text"
)

// SendHandler
// @ID account.reset.send.post
// @Summary Reset account password
// @Description Reset account password
// @Tags account
// @Accept json
// @Produce json
// @Param payload body resetRequest true "reset.resetRequest"
// @Success 200 {object} responder.InfoResponse
// @Failure 400 {object} responder.ErrorResponse
// @Router /account/reset/send [post]
func SendHandler(c *fiber.Ctx) error {
	// * Parse body
	var body resetRequest
	if err := c.BodyParser(&body); err != nil {
		return &responder.GenericError{
			Message: "Unable to parse body",
			Err:     err,
		}
	}

	// * Declare user record
	user := new(models.User)
	// * Generate verification pin
	pin := text.GenerateString(text.GenerateStringSet.Num, 6)

	// * Update reset pin
	if result := mgm.Coll(new(models.User)).FindOneAndUpdate(
		mgm.Ctx(),
		bson.M{"email": body.Email},
		bson.M{"$set": bson.M{"reset_token": pin}},
	); result.Err() == mongoDriver.ErrNoDocuments {
		return &responder.GenericError{
			Message: "No account with the email address provided found",
		}
	} else if result.Err() != nil {
		return &responder.GenericError{
			Message: "Unable to fetch user account",
			Err:     result.Err(),
		}
	} else {
		if err := result.Decode(user); err != nil {
			return &responder.GenericError{
				Message: "Unable to parse user account",
				Err:     result.Err(),
			}
		}
	}

	if err := mail.SendPasswordResetMail(*user.Firstname+" "+*user.Lastname, *pin, *user.Email); err != nil {
		return &responder.GenericError{
			Message: "Unable to send email, please try again later",
			Err:     err,
		}
	}

	return c.JSON(responder.InfoResponse{
		Success: true,
		Info:    "Verification email has sent, please use verification pin to confirm your request",
	})
}
