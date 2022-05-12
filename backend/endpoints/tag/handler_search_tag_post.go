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
)

// TagSearchPostHandler
// @ID tag.search.post
// @Summary Search a tag by name
// @Description Search a tag by name
// @Tags tag
// @Accept json
// @Produce json
// @Param payload body noteSearchPost true "tag.noteSearchPost"
// @Success 200 {object} tag.noteResponse
// @Failure 400 {object} responder.ErrorResponse
// @Router /tag/search [post]
func TagSearchPostHandler(c *fiber.Ctx) error {
	// * Parse user JWT token
	token := c.Locals("user").(*jwt.Token)
	claims := token.Claims.(*common.UserClaim)

	// * Parse body
	var body noteSearchPost
	if err := c.BodyParser(&body); err != nil {
		return &responder.GenericError{
			Message: "Unable to parse body",
			Err:     err,
		}
	}

	// * Parse string to object_id
	userId, _ := primitive.ObjectIDFromHex(*claims.UserId)

	// * Search the tag in notes
	var notes []noteObject
	if result, err := mgm.Coll(new(models.Notes)).Aggregate(mgm.Ctx(), bson.A{bson.M{
		"$match": bson.M{
			"user_id": userId,
			"tags": bson.M{
				"$in": bson.A{
					body.TagName,
				},
			},
		},
	}}); err != nil {
		return &responder.GenericError{
			Message: "Unable to fetch tags",
			Err:     err,
		}
	} else {
		for result.Next(mgm.Ctx()) {
			tempNote := new(models.Notes)
			if err := result.Decode(tempNote); err != nil {
				return &responder.GenericError{
					Message: "Unable to decode the result of notes",
					Err:     err,
				}
			}
			tempNoteObject := &noteObject{
				Title:     *tempNote.Title,
				Tags:      tempNote.Tags,
				NoteId:    tempNote.ID.Hex(),
				UpdatedAt: tempNote.UpdatedAt,
			}

			for _, detail := range tempNote.Details {
				if *detail.Type == "reminder" {
					tempNoteObject.HasReminder = true
				}
			}
			notes = append(notes, *tempNoteObject)
		}
	}

	return c.JSON(&responder.InfoResponse{
		Success: true,
		Data:    notes,
	})
}
