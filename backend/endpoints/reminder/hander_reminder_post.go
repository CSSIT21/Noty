package reminder

import (
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"github.com/kamva/mgm/v3"
	"go.mongodb.org/mongo-driver/bson/primitive"
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
// @Success 200 {object} responder.InfoResponse
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

	// * Parse string to object_id
	userId, _ := primitive.ObjectIDFromHex(*claims.UserId)
	noteId, _ := primitive.ObjectIDFromHex(body.NoteId)

	// * Validate body
	if err := text.Validate.Struct(body); err != nil {
		return err
	}

	// * Create reminder
	reminder := &models.Reminder{
		UserId:      &userId,
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
		Data: &reminderPostResponse{
			ReminderId: reminder.ID.Hex(),
		},
	})
}
