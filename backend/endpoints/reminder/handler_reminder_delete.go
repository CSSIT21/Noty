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

// ReminderDeleteHandler
// @ID reminder.delete
// @Summary Delete reminder
// @Description Delete reminder
// @Tags reminder
// @Accept json
// @Produce json
// @Param payload body reminderDeleteRequest true "reminder.reminderDeleteRequest"
// @Success 200 {object} responder.InfoResponse
// @Failure 400 {object} responder.ErrorResponse
// @Router /reminder/delete [delete]
func ReminderDeleteHandler(c *fiber.Ctx) error {
	// * Parse user JWT token
	token := c.Locals("user").(*jwt.Token)
	claims := token.Claims.(*common.UserClaim)

	// * Parse string to object_id
	userId, _ := primitive.ObjectIDFromHex(*claims.UserId)

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

	// * Parse folder id
	reminderId, _ := primitive.ObjectIDFromHex(body.ReminderId)

	// * Find the reminder
	reminder := new(models.Reminder)
	if err := mgm.Coll(reminder).First(bson.M{
		"_id":     reminderId,
		"user_id": userId,
	}, reminder); err != nil {
		return &responder.GenericError{
			Message: "Unable to find the reminder",
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
