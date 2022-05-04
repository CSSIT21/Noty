package note

import (
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"github.com/kamva/mgm/v3"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"noty-backend/loaders/mongo/models"
	"noty-backend/types/common"
	"noty-backend/types/responder"
)

// NotePostHandler
// @ID note.post
// @Summary Add a note
// @Description Add a note
// @Tags note
// @Accept json
// @Produce json
// @Param payload body notePostRequest true "note.notePostRequest"
// @Success 200 {object} responder.InfoResponse
// @Failure 400 {object} responder.ErrorResponse
// @Router /note/add [post]
func NotePostHandler(c *fiber.Ctx) error {
	// * Parse user JWT token
	token := c.Locals("user").(*jwt.Token)
	claims := token.Claims.(*common.UserClaim)

	// * Parse body
	var body notePostRequest
	if err := c.BodyParser(&body); err != nil {
		return &responder.GenericError{
			Message: "Unable to parse body",
			Err:     err,
		}
	}

	// * Parse string to object_id
	userId, _ := primitive.ObjectIDFromHex(*claims.UserId)

	var folderId *primitive.ObjectID

	if len(body.FolderId) == 0 {
		folderId = nil
	} else {
		tempFolderId, _ := primitive.ObjectIDFromHex(body.FolderId)
		folderId = &tempFolderId
	}

	note := new(models.Notes)
	var title string = "Untitled"
	note.Title = &title
	note.UserId = &userId
	note.FolderId = folderId

	// * Create a note
	if err := mgm.Coll(note).Create(note); err != nil {
		return &responder.GenericError{
			Message: "Unable to create note",
			Err:     err,
		}
	}

	return c.JSON(&responder.InfoResponse{
		Success: true,
		Info:    "Create a note successfully",
		Data: &notePostResponse{
			NoteId: note.ID.Hex(),
		},
	})
}
