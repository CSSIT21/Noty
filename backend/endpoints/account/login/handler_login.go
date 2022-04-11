package login

import (
	"github.com/gofiber/fiber/v2"
	"go.mongodb.org/mongo-driver/bson"
	mongoDriver "go.mongodb.org/mongo-driver/mongo"

	"noty-backend/loaders/mongo"
	"noty-backend/loaders/mongo/models"
	"noty-backend/types/responder"
	"noty-backend/utils/logger"
	"noty-backend/utils/text"
)

// LoginHandler
// @ID account.login.post
// @Summary Login to account
// @Description Login to account
// @Tags account
// @Accept json
// @Produce json
// @Param payload body loginRequest true "login.loginRequest"
// @Success 200 {object} loginResponse
// @Failure 400 {object} responder.ErrorResponse
// @Router /account/login [post]
func LoginHandler(c *fiber.Ctx) error {
	// * Parse body
	var body loginRequest
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

	// * Fetch user account
	var user *models.User
	if err := mongo.Collections.User.First(
		bson.M{"email": body.Email},
		user,
	); err == mongoDriver.ErrNoDocuments {
		return &responder.GenericError{
			Code:    "LOGIN_FAILED",
			Message: "No account associated with the email address",
		}
	} else if err != nil {
		return &responder.GenericError{
			Message: "Unable to fetch user account",
			Err:     err,
		}
	}

	logger.Dump(user)

	return c.JSON(responder.NewInfoResponse(&loginResponse{
		Token: "abcd",
	}))
}
