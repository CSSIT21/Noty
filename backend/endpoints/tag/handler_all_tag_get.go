package tag

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

// TagGetHandler
// @ID tag.get
// @Summary Get all tags
// @Description Get all tags
// @Tags tag
// @Accept json
// @Produce json
// @Success 200 {object} tag.tagAllGetResponse
// @Failure 400 {object} responder.ErrorResponse
// @Router /tag/list [get]
func TagGetHandler(c *fiber.Ctx) error {
	// * Parse user JWT token
	token := c.Locals("user").(*jwt.Token)
	claims := token.Claims.(*common.UserClaim)

	// * Parse string to object_id
	userId, _ := primitive.ObjectIDFromHex(*claims.UserId)

	// * Fetch all notes
	var notes []models.Notes
	if err := mgm.Coll(new(models.Notes)).SimpleFind(&notes, bson.M{
		"user_id": &userId,
	}); err != nil {
		return &responder.GenericError{
			Message: "Unable to fetch tags",
			Err:     err,
		}
	}

	var tags []string

	for _, tag := range notes {
		tags = append(tags, tag.Tags...)
	}

	// * Remove duplicate tag
	tags = text.RemoveDuplicate(tags)

	var tagsList []notesInTag

	// * Notes List for each tag
	for _, tag := range tags {
		var tempNoteObject []noteObject
		for _, note := range notes {
			for _, noteTag := range note.Tags {
				if noteTag == tag {
					tempNoteObject = append(tempNoteObject, noteObject{
						Title:  *note.Title,
						Tags:   note.Tags,
						NoteId: note.ID.Hex(),
					})
				}
			}
		}
		tempNoteInTag := &notesInTag{
			Name:  tag,
			Notes: tempNoteObject,
		}
		tagsList = append(tagsList, *tempNoteInTag)
	}

	return c.JSON(&responder.InfoResponse{
		Success: true,
		Data: &tagAllGetResponse{
			TagsName: tags,
			TagsList: tagsList,
		},
	})
}
