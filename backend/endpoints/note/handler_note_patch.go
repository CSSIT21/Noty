package note

import (
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"github.com/kamva/mgm/v3"
	"github.com/mitchellh/mapstructure"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"strings"

	"noty-backend/loaders/mongo/models"
	"noty-backend/types/common"
	"noty-backend/types/responder"
	"noty-backend/utils/text"
)

// NotePatchHandler
// @ID note.patch
// @Summary Edit note
// @Description Edit note
// @Tags note
// @Accept json
// @Produce json
// @Param payload body notePatchRequest true "note.notePatchRequest"
// @Success 200 {object} responder.InfoResponse
// @Failure 400 {object} responder.ErrorResponse
// @Router /note/edit [patch]
func NotePatchHandler(c *fiber.Ctx) error {
	// * Parse user JWT token
	token := c.Locals("user").(*jwt.Token)
	claims := token.Claims.(*common.UserClaim)

	// * Parse body
	var body notePatchRequest
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

	// * Parse string to object_id
	userId, _ := primitive.ObjectIDFromHex(*claims.UserId)
	folderId, _ := primitive.ObjectIDFromHex(body.FolderId)
	noteId, _ := primitive.ObjectIDFromHex(body.NoteId)

	var noteDetails []*models.NoteDetail
	var tags []string
	for _, detail := range body.NoteDetails {
		if detail.Type == "reminder" {
			reminderType := "reminder"
			reminderContent := new(ReminderContent)
			_ = mapstructure.Decode(detail.Data, reminderContent)

			// TODO: Decode reminder content
			tempReminderId, _ := primitive.ObjectIDFromHex(detail.Data.(map[string]any)["content"].(string))
			noteDetails = append(noteDetails, &models.NoteDetail{
				Type: &reminderType,
				Data: &models.ReminderContent{
					ReminderId: &tempReminderId,
				},
			})

			// * Update note_id in reminder
			if err := mgm.Coll(&models.Reminder{}).FindOneAndUpdate(mgm.Ctx(), bson.M{
				"_id":     tempReminderId,
				"user_id": userId,
			}, bson.M{"$set": bson.M{
				"note_id": noteId,
			}}); err.Err() != nil {
				return &responder.GenericError{
					Message: "Unable to update note_id in the reminder",
					Err:     err.Err(),
				}
			}

		} else {
			noteContent := new(models.NoteText)
			_ = mapstructure.Decode(detail.Data, noteContent)

			// * Find hashtags
			textArray := strings.Fields(*noteContent.Content)
			for _, s := range textArray {
				if strings.Index(s, "#") == 0 && len(s[1:]) <= 16 {
					tags = append(tags, s[1:])
				}
			}

			noteDetails = append(noteDetails, &models.NoteDetail{
				Type: &detail.Type,
				Data: &models.NoteText{
					Content: noteContent.Content,
				},
			})
		}
	}

	// * Remove duplicate tag
	tags = text.RemoveDuplicate(tags)

	// * Update note
	if err := mgm.Coll(&models.Notes{}).FindOneAndUpdate(mgm.Ctx(), bson.M{
		"_id":     noteId,
		"user_id": userId,
	}, bson.M{"$set": bson.M{
		"title":     &body.Title,
		"folder_id": &folderId,
		"user_id":   &userId,
		"details":   noteDetails,
		"tags":      tags,
	}}); err.Err() != nil {
		return &responder.GenericError{
			Message: "Unable to update note",
			Err:     err.Err(),
		}
	}

	return c.JSON(&responder.InfoResponse{
		Success: true,
		Info:    "Update note successfully",
	})
}
