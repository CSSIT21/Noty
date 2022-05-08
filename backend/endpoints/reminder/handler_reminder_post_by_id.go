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

// ReminderPostByIdHandler
// @ID reminder.by.id.post
// @Summary Find a reminder by id
// @Description  Find a reminder by id
// @Tags reminder
// @Accept json
// @Produce json
// @Param payload body reminderByIdPost true "reminder.reminderByIdPost"
// @Success 200 {object} reminderByIdPostResponse
// @Failure 400 {object} responder.ErrorResponse
// @Router /reminder/info/id [post]
func ReminderPostByIdHandler(c *fiber.Ctx) error {
	// * Parse user JWT token
	token := c.Locals("user").(*jwt.Token)
	claims := token.Claims.(*common.UserClaim)

	// * Parse body
	var body reminderByIdPost
	if err := c.BodyParser(&body); err != nil {
		return &responder.GenericError{
			Message: "Unable to parse body",
			Err:     err,
		}
	}

	// * Parse string to object_id
	userId, _ := primitive.ObjectIDFromHex(*claims.UserId)
	reminderId, _ := primitive.ObjectIDFromHex(body.ReminderId)

	// * Find a reminder
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

	return c.JSON(&responder.InfoResponse{
		Success: true,
		Data: &reminderByIdPostResponse{
			ReminderId:  reminder.ID.Hex(),
			Title:       *reminder.Title,
			Description: *reminder.Description,
			RemindDate:  *reminder.RemindDate,
			Success:     *reminder.Success,
		},
	})
}
