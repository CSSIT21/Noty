package reminder

import (
	"github.com/gofiber/fiber/v2"
	"github.com/kamva/mgm/v3"
	"noty-backend/loaders/mongo/models"
	"noty-backend/types/responder"
	"noty-backend/utils/text"
)

// ReminderPatchHandler
// @ID reminder.patch
// @Summary Patch reminder
// @Description Patch reminder
// @Tags reminder
// @Accept json
// @Produce json
// @Param payload body reminderPatchRequest true "reminder.reminderPatchRequest"
// @Success 200 {object} reminderPatchRequest
// @Failure 400 {object} responder.ErrorResponse
// @Router /reminder/edit [patch]
func ReminderPatchHandler(c *fiber.Ctx) error {
	// * Parse Body
	var body reminderPatchRequest
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
			Message: "Unable to fetch reminder",
			Err:     err,
		}
	} else {
		reminder.Title = &body.Title
		reminder.Description = &body.Description
		reminder.RemindDate = &body.RemindDate
		reminder.RemindTime = &body.RemindTime
	}

	// * Update the reminder
	if err := mgm.Coll(reminder).Update(reminder); err != nil {
		return &responder.GenericError{
			Message: "Unable to update reminder",
			Err:     err,
		}
	}

	return c.JSON(&responder.InfoResponse{
		Success: true,
		Info:    "Update the reminder successful",
	})
}
