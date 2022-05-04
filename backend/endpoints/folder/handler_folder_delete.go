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

// FolderDeleteHandler
// @ID folder.delete
// @Summary Delete folder
// @Description Delete folder
// @Tags folder
// @Accept json
// @Produce json
// @Param payload body folderDeleteRequest true "folder.folderDeleteRequest"
// @Success 200 {object} responder.InfoResponse
// @Failure 400 {object} responder.ErrorResponse
// @Router /folder/delete [delete]
func FolderDeleteHandler(c *fiber.Ctx) error {
	// * Parse user JWT token
	token := c.Locals("user").(*jwt.Token)
	claims := token.Claims.(*common.UserClaim)

	// * Parse Body
	var body folderDeleteRequest
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

	// * Delete the folder
	if err := mgm.Coll(&models.Folder{}).FindOneAndDelete(mgm.Ctx(), bson.M{
		"_id":     folderId,
		"user_id": &userId,
	}); err.Err() != nil {
		return &responder.GenericError{
			Message: "Unable to find the folder",
			Err:     err.Err(),
		}
	}

	return c.JSON(&responder.InfoResponse{
		Success: true,
		Info:    "Delete folder successful",
	})
}
