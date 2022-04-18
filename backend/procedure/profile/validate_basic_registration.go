package profile

import (
	"go.mongodb.org/mongo-driver/bson"
	mongoDriver "go.mongodb.org/mongo-driver/mongo"
	"noty-backend/loaders/mongo"
	"noty-backend/loaders/mongo/models"
	"noty-backend/types/responder"
)

func ValidateBasicRegistration(profile *models.User, password string) *responder.GenericError {
	// * Validate Password
	if len(password) < 8 || len(password) > 255 {
		return &responder.GenericError{
			Code:    "INVALID_INFORMATION",
			Message: "Password length must be between 8 to 255 characters",
		}
	}

	// * Check Duplicate Email
	user := new(models.User)
	if err := mongo.Collections.User.First(bson.M{
		"email": profile.Email,
	}, user); err != mongoDriver.ErrNoDocuments {
		return &responder.GenericError{
			Message: "This email already used",
			Err:     err,
		}
	}

	return nil
}
