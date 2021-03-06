package note

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

// NoteDeleteHandler
// @ID note.delete
// @Summary Delete a note
// @Description Delete a note
// @Tags note
// @Accept json
// @Produce json
// @Param payload body noteDeleteRequest true "note.noteDeleteRequest"
// @Success 200 {object} responder.InfoResponse
// @Failure 400 {object} responder.ErrorResponse
// @Router /note/delete [delete]
func NoteDeleteHandler(c *fiber.Ctx) error {
	// * Parse user JWT token
	token := c.Locals("user").(*jwt.Token)
	claims := token.Claims.(*common.UserClaim)

	// * Parse Body
	var body noteDeleteRequest
	if err := c.BodyParser(&body); err != nil {
		return &responder.GenericError{
			Message: "Unable to parse body",
			Err:     err,
		}
	}

	// * Parse string to object_id
	noteId, _ := primitive.ObjectIDFromHex(body.NoteId) // * Parse string to object_id
	userId, _ := primitive.ObjectIDFromHex(*claims.UserId)

	note := new(models.Notes)

	// * Find the note
	if err := mgm.Coll(note).First(bson.M{
		"_id":     noteId,
		"user_id": userId,
	}, note); err != nil {
		return &responder.GenericError{
			Message: "Unable to find the note",
			Err:     err,
		}
	}

	// * Delete reminders in the note
	reminder := new(models.Reminder)
	if _, err := mgm.Coll(reminder).DeleteMany(mgm.Ctx(), bson.M{
		"note_id": noteId,
		"user_id": userId,
	}); err != nil {
		return &responder.GenericError{
			Message: "Unable to delete reminders",
			Err:     err,
		}
	}

	// * Delete the note
	if err := mgm.Coll(note).FindOneAndDelete(mgm.Ctx(), bson.M{
		"_id":     noteId,
		"user_id": userId,
	}); err.Err() != nil {
		return &responder.GenericError{
			Message: "Unable to delete the note",
			Err:     err.Err(),
		}
	}

	return c.JSON(&responder.InfoResponse{
		Success: true,
		Info:    "Delete note successful",
	})
}
