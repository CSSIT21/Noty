package reminder

import (
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"github.com/kamva/mgm/v3"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"noty-backend/loaders/mongo/models"
	"noty-backend/types/common"
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
// @Success 200 {object} responder.InfoResponse
// @Failure 400 {object} responder.ErrorResponse
// @Router /reminder/edit [patch]
func ReminderPatchHandler(c *fiber.Ctx) error {
	// * Parse user JWT token
	token := c.Locals("user").(*jwt.Token)
	claims := token.Claims.(*common.UserClaim)

	// * Parse string to object_id
	userId, _ := primitive.ObjectIDFromHex(*claims.UserId)

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

	// * Parse folder id
	reminderId, _ := primitive.ObjectIDFromHex(body.ReminderId)

	// * Find the reminder
	reminder := new(models.Reminder)
	if err := mgm.Coll(reminder).First(bson.M{
		"_id":     reminderId,
		"user_id": userId,
	}, reminder); err != nil {
		return &responder.GenericError{
			Message: "Unable to fetch reminder",
			Err:     err,
		}
	} else {
		reminder.Title = &body.Title
		reminder.Description = &body.Description
	}

	if !body.RemindDate.IsZero() {
		reminder.RemindDate = &body.RemindDate
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
