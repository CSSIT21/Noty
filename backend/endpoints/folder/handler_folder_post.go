package folder

import (
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"github.com/kamva/mgm/v3"
	"go.mongodb.org/mongo-driver/bson"
	mongoDriver "go.mongodb.org/mongo-driver/mongo"
	"noty-backend/loaders/mongo"
	"noty-backend/loaders/mongo/models"
	"noty-backend/types/common"
	"noty-backend/types/responder"
	"noty-backend/utils/text"
)

// FolderPostHandler
// @ID folder.post
// @Summary Add folder
// @Description Add folder
// @Tags folder
// @Accept json
// @Produce json
// @Param payload body folderPostRequest true "folder.folderPostRequest"
// @Success 200 {object} folderPostRequest
// @Failure 400 {object} responder.ErrorResponse
// @Router /folder/add [post]
func FolderPostReminder(c *fiber.Ctx) error {
	// * Parse user JWT token
	token := c.Locals("user").(*jwt.Token)
	claims := token.Claims.(*common.UserClaim)

	// * Parse Body
	var body folderPostRequest
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

	// * Create folder
	folder := &models.Folder{
		UserId: claims.UserId,
		Name:   &body.Name,
	}

	// * Check Duplicate folder
	if err := mongo.Collections.Folder.First(bson.M{
		"user_id": claims.UserId,
		"name":    body.Name,
	}, folder); err != mongoDriver.ErrNoDocuments {
		return &responder.GenericError{
			Message: "There is already a folder named this",
			Err:     err,
		}
	}

	if err := mgm.Coll(folder).Create(folder); err != nil {
		return &responder.GenericError{
			Message: "Unable to create folder",
			Err:     err,
		}
	}

	return c.JSON(&responder.InfoResponse{
		Success: true,
		Info:    "Add folder successful",
	})
}
