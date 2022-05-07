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
)

// ReminderProgressPatchHandler
// @ID reminder.progress.patch
// @Summary Update reminder progress
// @Description  pdate reminder progress
// @Tags reminder
// @Accept json
// @Produce json
// @Param payload body reminderProgressPatch true "reminder.reminderProgressPatch"
// @Success 200 {object} responder.InfoResponse
// @Failure 400 {object} responder.ErrorResponse
// @Router /reminder/update/progress [patch]
func ReminderPrgressPatchHandler(c *fiber.Ctx) error {
	// * Parse user JWT token
	token := c.Locals("user").(*jwt.Token)
	claims := token.Claims.(*common.UserClaim)

	// * Parse body
	var body reminderProgressPatch
	if err := c.BodyParser(&body); err != nil {
		return &responder.GenericError{
			Message: "Unable to parse body",
			Err:     err,
		}
	}

	// * Parse string to object_id
	userId, _ := primitive.ObjectIDFromHex(*claims.UserId)
	reminderId, _ := primitive.ObjectIDFromHex(body.ReminderId)

	if err := mgm.Coll(new(models.Reminder)).FindOneAndUpdate(mgm.Ctx(), bson.M{
		"_id":     reminderId,
		"user_id": userId,
	}, bson.M{"$set": bson.M{
		"success": body.Success,
	}}); err.Err() != nil {
		return &responder.GenericError{
			Message: "Unable to update your reminder progress",
			Err:     err.Err(),
		}
	}

	return c.JSON(&responder.InfoResponse{
		Success: true,
		Info:    "Update your reminder progress successfully",
	})
}
