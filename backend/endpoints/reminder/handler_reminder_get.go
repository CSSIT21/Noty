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

// ReminderGetHandler
// @ID reminder.get
// @Summary Get all reminder
// @Description Get all reminders
// @Tags reminder
// @Accept json
// @Produce json
// @Success 200 {object} responder.InfoResponse
// @Failure 400 {object} responder.ErrorResponse
// @Router /reminder/info [get]
func ReminderGetHandler(c *fiber.Ctx) error {
	// * Parse user JWT token
	token := c.Locals("user").(*jwt.Token)
	claims := token.Claims.(*common.UserClaim)

	// * Parse string to object_id
	userId, _ := primitive.ObjectIDFromHex(*claims.UserId)

	// * Fetch reminders without note_id
	var independentRemindersResponse []*independentReminders
	if result, err := mgm.Coll(&models.Reminder{}).Find(mgm.Ctx(), bson.M{
		"user_id": userId,
		"note_id": primitive.ObjectID{},
	}); err != nil {
		return &responder.GenericError{
			Message: "Unable to fetch reminders",
			Err:     err,
		}
	} else {
		for result.Next(mgm.Ctx()) {
			tempReminder := new(models.Reminder)
			if err := result.Decode(tempReminder); err != nil {
				return &responder.GenericError{
					Message: "Unable decode the result of Independent Reminders",
					Err:     err,
				}
			}
			tempIndependentReminder := &independentReminders{
				ReminderId:  tempReminder.ID.Hex(),
				Title:       *tempReminder.Title,
				Description: *tempReminder.Description,
				RemindDate:  *tempReminder.RemindDate,
			}
			independentRemindersResponse = append(independentRemindersResponse, tempIndependentReminder)
		}
	}

	// * Fetch reminders in notes
	var allNotes []*noteAllGetDecoded
	if result, err := mgm.Coll(new(models.Notes)).Aggregate(mgm.Ctx(), bson.A{bson.M{
		"$match": bson.M{
			"user_id": userId,
		},
	}, bson.M{
		"$lookup": bson.M{
			"from":         "reminders",
			"localField":   "_id",
			"foreignField": "note_id",
			"as":           "reminders",
		},
	}, bson.M{
		"$match": bson.M{
			"reminders.0": bson.M{"$exists": true},
		},
	},
	}); err != nil {
		return &responder.GenericError{
			Message: "Unable to fetch reminders in notes",
			Err:     err,
		}
	} else {
		for result.Next(mgm.Ctx()) {
			tempReminder := new(noteAllGetDecode)
			if err := result.Decode(tempReminder); err != nil {
				return &responder.GenericError{
					Message: "Unable decode the result of Notes Reminders",
					Err:     err,
				}
			}
			decoded := &noteAllGetDecoded{
				NoteId:    tempReminder.NoteId.Hex(),
				Title:     tempReminder.Title,
				Reminders: tempReminder.Reminders,
			}
			allNotes = append(allNotes, decoded)
		}
	}

	return c.JSON(&responder.InfoResponse{
		Success: true,
		Data: reminderGetResponse{
			IndependentReminders: independentRemindersResponse,
			NotesReminders:       allNotes,
		},
	})
}
