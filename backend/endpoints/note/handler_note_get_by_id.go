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

// NoteGetByIdHandler
// @ID note.by.id.get
// @Summary Get note by id
// @Description Get note by id
// @Tags note
// @Accept json
// @Produce json
// @Param payload body noteGetByIdRequest true "note.noteGetByIdRequest"
// @Success 200 {object} responder.InfoResponse
// @Failure 400 {object} responder.ErrorResponse
// @Router /note/info/id [get]
func NoteGetByIdHandler(c *fiber.Ctx) error {
	// * Parse user JWT token
	token := c.Locals("user").(*jwt.Token)
	claims := token.Claims.(*common.UserClaim)

	// * Parse Body
	var body noteGetByIdRequest
	if err := c.BodyParser(&body); err != nil {
		return &responder.GenericError{
			Message: "Unable to parse body",
			Err:     err,
		}
	}

	// * Parse string to object_id
	userId, _ := primitive.ObjectIDFromHex(*claims.UserId)
	noteId, _ := primitive.ObjectIDFromHex(body.NoteId)

	// * Get the note
	note := new(models.Notes)
	if err := mgm.Coll(note).First(bson.M{
		"_id":     noteId,
		"user_id": userId,
	}, note); err != nil {
		return &responder.GenericError{
			Message: "Unable to fetch the note",
			Err:     err,
		}
	}

	return c.JSON(&responder.InfoResponse{
		Success: true,
		Data:    note,
	})
}
