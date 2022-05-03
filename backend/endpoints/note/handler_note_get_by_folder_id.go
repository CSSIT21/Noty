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

// NoteGetByFolderIdHandler
// @ID note.by.folder_id.get
// @Summary Get notes in folder
// @Description Get notes in folder
// @Tags note
// @Accept json
// @Produce json
// @Param payload body noteGetByFolderId true "note.noteGetByFolderId"
// @Failure 400 {object} noteGetNotesResponse
// @Router /note/info/folder [get]
func NoteGetByFolderId(c *fiber.Ctx) error {
	// * Parse user JWT token
	token := c.Locals("user").(*jwt.Token)
	claims := token.Claims.(*common.UserClaim)

	// * Parse Body
	var body noteGetByFolderId
	if err := c.BodyParser(&body); err != nil {
		return &responder.GenericError{
			Message: "Unable to parse body",
			Err:     err,
		}
	}

	// * Parse string to object_id
	userId, _ := primitive.ObjectIDFromHex(*claims.UserId)
	folderId, _ := primitive.ObjectIDFromHex(body.FolderId)

	// * Fetch all notes in folder id
	var notes []*noteGetNotesResponse
	if result, err := mgm.Coll(&models.Notes{}).Find(mgm.Ctx(), bson.M{
		"folder_id": folderId,
		"user_id":   userId,
	}); err != nil {
		return &responder.GenericError{
			Message: "Unable to fetch all notes",
			Err:     err,
		}
	} else {
		for result.Next(mgm.Ctx()) {
			tempNote := new(models.Notes)
			if err := result.Decode(tempNote); err != nil {
				return &responder.GenericError{
					Message: "Unable to decode notes result",
					Err:     err,
				}
			}
			tempNoteResponse := &noteGetNotesResponse{
				NoteId:    tempNote.ID.Hex(),
				Title:     *tempNote.Title,
				Tags:      tempNote.Tags,
				CreatedAt: tempNote.CreatedAt,
			}
			for _, check := range tempNote.Details {
				if *check.Type == "reminder" {
					tempNoteResponse.HasReminder = true
				}
			}
			notes = append(notes, tempNoteResponse)
		}
	}
	return c.JSON(&responder.InfoResponse{
		Success: true,
		Data:    notes,
	})
}
