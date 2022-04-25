package reminder

import (
	"github.com/gofiber/fiber/v2"
	"github.com/kamva/mgm/v3"
	"noty-backend/loaders/mongo/models"
	"noty-backend/types/responder"
	"noty-backend/utils/text"
)

// ReminderDeleteHandler
// @ID reminder.delete
// @Summary Delete reminder
// @Description Delete reminder
// @Tags reminder
// @Accept json
// @Produce json
// @Param payload body reminderDeleteRequest true "reminder.reminderDeleteRequest"
// @Success 200 {object} reminderDeleteRequest
// @Failure 400 {object} responder.ErrorResponse
// @Router /reminder/delete [delete]
func ReminderDeleteHandler(c *fiber.Ctx) error {
	// * Parse Body
	var body reminderDeleteRequest
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

	// * Find the reminder
	reminder := new(models.Reminder)
	if err := mgm.Coll(reminder).FindByID(body.ReminderId, reminder); err != nil {
		return &responder.GenericError{
			Message: "Unable to fetch the reminder",
			Err:     err,
		}
	}

	// * Delete reminder
	if err := mgm.Coll(reminder).Delete(reminder); err != nil {
		return &responder.GenericError{
			Message: "Unable to delete the reminder",
			Err:     err,
		}
	}

	return c.JSON(&responder.InfoResponse{
		Success: true,
		Info:    "Delete reminder successful",
	})
}
