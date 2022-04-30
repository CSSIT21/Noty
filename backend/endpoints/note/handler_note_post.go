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
	"noty-backend/utils/text"
)

// NotePostHandler
// @ID note.post
// @Summary Add note
// @Description Add note
// @Tags note
// @Accept json
// @Produce json
// @Param payload body notePostRequest true "note.notePostRequest"
// @Success 200 {object} responder.InfoResponse
// @Failure 400 {object} responder.ErrorResponse
// @Router /note/add [post]
func NotePostHandler(c *fiber.Ctx) error {
	// * Parse user JWT token
	token := c.Locals("user").(*jwt.Token)
	claims := token.Claims.(*common.UserClaim)

	// * Parse body
	var body notePostRequest
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

	var details []*models.NoteDetail

	// * Store reminder_id after creating each reminder
	var remindersId []string

	// * Map note data into details array
	for _, detail := range body.NoteDetails {
		if detail.Type == "reminder" {
			// * Create each reminder
			reminderContent := new(ReminderContent)
			_ = mapstructure.Decode(detail.Data, reminderContent)
			reminder := &models.Reminder{
				UserId:      &userId,
				Title:       &reminderContent.Title,
				Description: &reminderContent.Description,
				RemindDate:  &reminderContent.RemindDate,
				RemindTime:  &reminderContent.RemindTime,
				NoteId:      nil,
			}
			if err := mgm.Coll(reminder).Create(reminder); err != nil {
				return &responder.GenericError{
					Message: "Unable to create reminder",
					Err:     err,
				}
			} else {
				reminderType := "reminder"
				// * Append reminder id into note_details
				details = append(details, &models.NoteDetail{
					Type: &reminderType,
					Data: reminder.ID.Hex(),
				})
				// * Append reminder_id into remindersId array
				remindersId = append(remindersId, reminder.ID.Hex())
			}
		} else {
			// * Create each note and append into note_details
			reminderData := new(NoteText)
			_ = mapstructure.Decode(detail.Data, reminderData)
			details = append(details, &models.NoteDetail{
				Type: &detail.Type,
				Data: &NoteText{
					Detail: reminderData.Detail,
				},
			})
		}
	}

	note := &models.Notes{
		Title:    &body.Title,
		FolderId: &folderId,
		Details:  details,
		UserId:   &userId,
	}

	// * Create note
	if err := mgm.Coll(note).Create(note); err != nil {
		return &responder.GenericError{
			Message: "Unable to create note",
			Err:     err,
		}
	}

	// * Update note_id in each reminder
	for _, id := range remindersId {
		// * Parse reminder id
		tempReminderId, _ := primitive.ObjectIDFromHex(id)
		tempReminder := new(models.Reminder)
		// * Find each reminder
		if err := mgm.Coll(tempReminder).First(bson.M{
			"_id":     tempReminderId,
			"user_id": &userId,
		}, tempReminder); err != nil {
			return &responder.GenericError{
				Message: "Unable to find reminder id " + id,
				Err:     err,
			}
		} else {
			// * Update note_id in each reminder
			tempReminder.NoteId = &note.ID
			if errUpdate := mgm.Coll(tempReminder).Update(tempReminder); errUpdate != nil {
				return &responder.GenericError{
					Message: "Unable to update note_id into reminder id " + id,
					Err:     errUpdate,
				}
			}
		}
	}

	return c.JSON(&responder.InfoResponse{
		Success: true,
		Info:    "Create note successfully",
	})
}
