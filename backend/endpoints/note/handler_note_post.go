package note

import (
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"github.com/kamva/mgm/v3"
	"noty-backend/loaders/mongo/models"
	"noty-backend/types/common"
	"noty-backend/types/responder"
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

	var details []*models.NoteDetail

	// * Map note data into details array
	for _, detail := range body.NoteDetails {
		if detail.Type == "reminder" {
			noteId := ""
			reminder := &models.Reminder{
				UserId:      claims.UserId,
				Title:       &detail.Data.(*ReminderContent).Title,
				Description: &detail.Data.(*ReminderContent).Description,
				RemindDate:  &detail.Data.(*ReminderContent).RemindDate,
				RemindTime:  &detail.Data.(*ReminderContent).RemindTime,
				NoteId:      &noteId,
			}
			if err := mgm.Coll(reminder).Create(reminder); err != nil {
				return &responder.GenericError{
					Message: "Unable to create reminder",
					Err:     err,
				}
			} else {
				reminderType := "reminder"
				details = append(details, &models.NoteDetail{
					Type: &reminderType,
					Data: reminder.ID,
				})
			}
		} else {
			details = append(details, &models.NoteDetail{
				Type: &detail.Type,
				Data: &NoteText{
					Detail: detail.Data.(*NoteText).Detail,
				},
			})
		}
	}

	note := &models.Notes{
		Title:    &body.Title,
		FolderId: &body.FolderId,
		Details:  details,
	}

	// * Create note
	if err := mgm.Coll(note).Create(note); err != nil {
		return &responder.GenericError{
			Message: "Unable to create note",
			Err:     err,
		}
	}

	return c.JSON(&responder.InfoResponse{
		Success: true,
		Info:    "Create note successfully",
	})
}
