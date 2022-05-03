package note

import (
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"github.com/kamva/mgm/v3"
	"github.com/mitchellh/mapstructure"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"noty-backend/loaders/mongo/models"
	"noty-backend/types/common"
	"noty-backend/types/responder"
)

// NotePostByIdHandler
// @ID note.by.id.post
// @Summary Get note by id
// @Description Get note by id
// @Tags note
// @Accept json
// @Produce json
// @Param payload body noteGetByIdRequest true "note.noteGetByIdRequest"
// @Success 200 {object} responder.InfoResponse
// @Failure 400 {object} responder.ErrorResponse
// @Router /note/info/id [post]
func NotePostByIdHandler(c *fiber.Ctx) error {
	// * Parse user JWT token
	token := c.Locals("user").(*jwt.Token)
	claims := token.Claims.(*common.UserClaim)

	// * Parse Body
	var body noteGetByIdRequest
	if err := c.BodyParser(&body); err != nil {
		return &responder.GenericError{
			Message: "Unable to parse body",
			Err:     err,
		}
	}

	// * Parse string to object_id
	userId, _ := primitive.ObjectIDFromHex(*claims.UserId)
	noteId, _ := primitive.ObjectIDFromHex(body.NoteId)

	// * Get the note
	note := new(models.Notes)
	if err := mgm.Coll(note).First(bson.M{
		"_id":     noteId,
		"user_id": userId,
	}, note); err != nil {
		return &responder.GenericError{
			Message: "Unable to fetch the note",
			Err:     err,
		}
	}

	tempNote := &noteGetByIdDetailResponse{
		NoteId:    note.ID.Hex(),
		Title:     *note.Title,
		FolderId:  note.FolderId.Hex(),
		UpdatedAt: note.UpdatedAt,
		Tags:      note.Tags,
	}

	var noteDetails []*noteGetTypeDetailData
	for _, detail := range note.Details {
		if *detail.Type == "reminder" {
			tempReminder := new(noteGetReminderId)
			tempDetails := detail.Data.(primitive.D).Map()
			bsonBytes, _ := bson.Marshal(tempDetails)
			bson.Unmarshal(bsonBytes, &tempReminder)
			tempNoteGetDetailData := &noteGetDetailData{
				Content: tempReminder.ReminderId.Hex(),
			}
			tempDetail := &noteGetTypeDetailData{
				Type: *detail.Type,
				Data: tempNoteGetDetailData,
			}
			noteDetails = append(noteDetails, tempDetail)
		} else {
			tempReminder := new(noteGetContent)
			tempDetails := detail.Data.(primitive.D).Map()
			bsonBytes, _ := bson.Marshal(tempDetails)
			bson.Unmarshal(bsonBytes, &tempReminder)
			_ = mapstructure.Decode(detail.Data, tempReminder)
			tempNoteGetDetailData := &noteGetDetailData{
				Content: tempReminder.Content,
			}
			tempDetail := &noteGetTypeDetailData{
				Type: *detail.Type,
				Data: tempNoteGetDetailData,
			}
			noteDetails = append(noteDetails, tempDetail)
		}
	}

	tempNote.Data = noteDetails

	return c.JSON(&responder.InfoResponse{
		Success: true,
		Data:    tempNote,
	})
}
