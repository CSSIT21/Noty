package register

import (
	"github.com/gofiber/fiber/v2"
	"github.com/kamva/mgm/v3"
	"noty-backend/loaders/mongo/models"
	"noty-backend/procedure/profile"
	"noty-backend/procedure/signing"
	"noty-backend/types/common"
	"noty-backend/types/responder"
	"noty-backend/utils/crypto"
	"noty-backend/utils/text"
)

// RegisterHandler
// @ID account.register.post
// @Summary Register account
// @Description Register account
// @Tags account
// @Accept json
// @Produce json
// @Param payload body registerRequest true "register.registerRequest"
// @Success 200 {object} registerResponse
// @Failure 400 {object} responder.ErrorResponse
// @Router /account/register [post]
func RegisterHandler(c *fiber.Ctx) error {
	// * Parse body
	var body registerRequest
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

	// * Validate Basic Registration
	if err := profile.ValidateBasicRegistration(&models.User{
		Email: &body.Email,
	}, body.Password); err != nil {
		return err
	}

	// * Hash Password
	hashedPassword, _ := crypto.HashPassword(body.Password)

	// * Create User
	user := &models.User{
		Email:      &body.Email,
		Password:   &hashedPassword,
		Firstname:  &body.Firstname,
		Lastname:   &body.Lastname,
		ResetToken: nil,
	}
	if err := mgm.Coll(user).Create(user); err != nil {
		return &responder.GenericError{
			Message: "Unable to create user",
			Err:     err,
		}
	}

	// * Parse ObjectID to string
	idString := user.ID.Hex()

	// * Sign JWT
	token, err := signing.SignJwt(&common.UserClaim{
		UserId: &idString,
	})
	if err != nil {
		return err
	}

	return c.JSON(responder.NewInfoResponse(&registerResponse{
		Token: token,
	}))
}
