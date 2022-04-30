package folder

import (
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"github.com/kamva/mgm/v3"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"noty-backend/loaders/mongo/models"
	"noty-backend/types/common"
	"noty-backend/types/responder"
	"noty-backend/utils/text"
)

// FolderPatchHandler
// @ID folder.patch
// @Summary Patch folder
// @Description Patch folder
// @Tags folder
// @Accept json
// @Produce json
// @Param payload body folderPatchRequest true "folder.folderPatchRequest"
// @Success 200 {object} responder.InfoResponse
// @Failure 400 {object} responder.ErrorResponse
// @Router /folder/edit [patch]
func FolderPatchHandler(c *fiber.Ctx) error {
	// * Parse user JWT token
	token := c.Locals("user").(*jwt.Token)
	claims := token.Claims.(*common.UserClaim)

	// * Parse Body
	var body folderPatchRequest
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

	// * Parse string id to object id
	folderId, _ := primitive.ObjectIDFromHex(body.FolderId)
	userId, _ := primitive.ObjectIDFromHex(*claims.UserId)

	// * Find the folder
	folder := new(models.Folder)
	if err := mgm.Coll(folder).First(bson.M{
		"_id":     folderId,
		"user_id": &userId,
	}, folder); err != nil {
		return &responder.GenericError{
			Message: "Unable to find the folder",
			Err:     err,
		}
	} else {
		folder.Name = &body.NewName
	}

	// * Update folder name
	if err := mgm.Coll(folder).Update(folder); err != nil {
		return &responder.GenericError{
			Message: "Unable to change the name of folder",
			Err:     err,
		}
	}

	return c.JSON(&responder.InfoResponse{
		Success: true,
		Info:    "Change the name of folder successful",
	})
}
