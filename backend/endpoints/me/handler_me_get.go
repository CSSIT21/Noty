package me

import (
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"github.com/kamva/mgm/v3"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	mongoDriver "go.mongodb.org/mongo-driver/mongo"
	"noty-backend/loaders/mongo/models"
	"noty-backend/types/common"
	"noty-backend/types/responder"
	"noty-backend/utils/text"
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

	// * Parse string to object_id
	userId, _ := primitive.ObjectIDFromHex(*claims.UserId)

	// * Get user information
	user := new(models.User)
	if err := mgm.Coll(user).FindByID(*claims.UserId, user); err != nil {
		return &responder.GenericError{
			Message: "Unable to fetch user information",
			Err:     err,
		}
	}

	var pictureId string
	if user.PictureId != nil {
		pictureId = user.PictureId.Hex()
	} else {
		pictureId = ""
	}

	data := &meGetResponse{
		UserId:    user.ID.Hex(),
		Firstname: *user.Firstname,
		Lastname:  *user.Lastname,
		Email:     *user.Email,
		PictureId: pictureId,
	}

	// * Get all notes
	var notes []models.Notes
	if err := mgm.Coll(&models.Notes{}).SimpleFind(&notes, bson.M{
		"user_id": userId,
	}); err == mongoDriver.ErrNoDocuments {
		data.Notes = 0
	} else if err != nil {
		return &responder.GenericError{
			Message: "Unable to fetch notes",
			Err:     err,
		}
	} else {
		data.Notes = uint64(len(notes))
	}

	// * Get all tags
	var tags []string
	for _, tag := range notes {
		tags = append(tags, tag.Tags...)
	}
	// * Remove duplicate tag
	tags = text.RemoveDuplicate(tags)
	data.Tags = uint64(len(tags))

	// * Get all reminders
	reminders := new([]models.Reminder)
	if err := mgm.Coll(&models.Reminder{}).SimpleFind(reminders, bson.M{
		"user_id": &userId,
	}); err == mongoDriver.ErrNoDocuments {
		data.Reminders = 0
	} else if err != nil {
		return &responder.GenericError{
			Message: "Unable to fetch reminders",
			Err:     err,
		}
	} else {
		data.Reminders = uint64(len(*reminders))
	}

	// * Get all folders
	folders := new([]models.Folder)
	if err := mgm.Coll(&models.Folder{}).SimpleFind(folders, bson.M{
		"user_id": &userId,
	}); err == mongoDriver.ErrNoDocuments {
		data.Folders = 0
	} else if err != nil {
		return &responder.GenericError{
			Message: "Unable to fetch folders",
			Err:     err,
		}
	} else {
		data.Folders = uint64(len(*folders))
	}

	return c.JSON(&responder.InfoResponse{
		Success: true,
		Data:    data,
	})
}
