package note

import (
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"github.com/kamva/mgm/v3"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"noty-backend/loaders/mongo/models"
	"noty-backend/types/common"
	"noty-backend/types/responder"
)

// NoteFolderPatchHandler
// @ID note.folder.patch
// @Summary Move note into folder
// @Description Move note into folder
// @Tags note
// @Accept json
// @Produce json
// @Param payload body noteFolderPatchRequest true "note.noteFolderPatchRequest"
// @Success 200 {object} responder.InfoResponse
// @Failure 400 {object} responder.ErrorResponse
// @Router /note/move [patch]
func NoteFolderPatchHandler(c *fiber.Ctx) error {
	// * Parse user JWT token
	token := c.Locals("user").(*jwt.Token)
	claims := token.Claims.(*common.UserClaim)

	// * Parse Body
	var body noteFolderPatchRequest
	if err := c.BodyParser(&body); err != nil {
		return &responder.GenericError{
			Message: "Unable to parse body",
			Err:     err,
		}
	}

	// * Parse string to object_id
	userId, _ := primitive.ObjectIDFromHex(*claims.UserId)
	folderId, _ := primitive.ObjectIDFromHex(body.FolderId)

	var noteId *primitive.ObjectID

	if len(body.NoteId) == 0 {
		noteId = nil
	} else {
		tempNoteId, _ := primitive.ObjectIDFromHex(body.NoteId)
		noteId = &tempNoteId
	}

	// * Add folder_id into note
	if result := mgm.Coll(&models.Notes{}).FindOneAndUpdate(mgm.Ctx(), bson.M{
		"_id":     noteId,
		"user_id": userId,
	}, bson.M{"$set": bson.M{
		"folder_id": folderId,
	}}); result.Err() != nil {
		return &responder.GenericError{
			Message: "Unable to update note",
			Err:     result.Err(),
		}
	}

	return c.JSON(&responder.InfoResponse{
		Success: true,
		Info:    "Update note and folder successfully",
	})
}
