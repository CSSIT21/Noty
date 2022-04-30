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

	// * Update folder name
	if err := mgm.Coll(&models.Folder{}).FindOneAndUpdate(mgm.Ctx(), bson.M{
		"_id":     folderId,
		"user_id": &userId,
	}, bson.M{
		"name": body.NewName,
	}); err.Err() != nil {
		return &responder.GenericError{
			Message: "Unable to find the folder",
			Err:     err.Err(),
		}
	}

	return c.JSON(&responder.InfoResponse{
		Success: true,
		Info:    "Change the name of folder successfully",
	})
}
