package reminder

import (
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"github.com/kamva/mgm/v3"
	"noty-backend/loaders/mongo/models"
	"noty-backend/types/common"
	"noty-backend/types/responder"
	"noty-backend/utils/text"
)

// ReminderPostHandler
// @ID reminder.post
// @Summary Add reminder
// @Description Add reminder
// @Tags reminder
// @Accept json
// @Produce json
// @Param payload body reminderPostRequest true "reminder.reminderPostRequest"
// @Success 200 {object} reminderPostRequest
// @Failure 400 {object} responder.ErrorResponse
// @Router /reminder/add [post]
func ReminderPostHandler(c *fiber.Ctx) error {
	// * Parse user JWT token
	token := c.Locals("user").(*jwt.Token)
	claims := token.Claims.(*common.UserClaim)

	// * Parse Body
	var body reminderPostRequest
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

	var noteId string
	if len(body.NoteId) > 0 {
		noteId = body.NoteId
	}

	// * Create reminder
	reminder := &models.Reminder{
		UserId:      claims.UserId,
		Title:       &body.Title,
		Description: &body.Description,
		NoteId:      &noteId,
		RemindDate:  &body.RemindDate,
		RemindTime:  &body.RemindTime,
	}

	if err := mgm.Coll(reminder).Create(reminder); err != nil {
		return &responder.GenericError{
			Message: "Unable to create reminder",
			Err:     err,
		}
	}

	return c.JSON(&responder.InfoResponse{
		Success: true,
		Info:    "Add reminder successful",
	})
}
