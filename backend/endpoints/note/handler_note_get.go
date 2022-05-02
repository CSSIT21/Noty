package note

import (
	"github.com/gofiber/fiber/v2"
	"github.com/kamva/mgm/v3"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"noty-backend/loaders/mongo/models"
	"noty-backend/types/responder"
	"noty-backend/utils/logger"
)

// NoteGetHandler
// @ID note.get
// @Summary Get all notes and folders
// @Description Get all notes and folders
// @Tags note
// @Accept json
// @Produce json
// @Success 200 {object} responder.InfoResponse
// @Failure 400 {object} responder.ErrorResponse
// @Router /note/info [get]
func NoteGetHandler(c *fiber.Ctx) error {
	// * Parse user JWT token
	//token := c.Locals("user").(*jwt.Token)
	//claims := token.Claims.(*common.UserClaim)

	userId, _ := primitive.ObjectIDFromHex("626d8d6141e7c73a9af2d73b")

	var folders []*noteGetResponse
	if result, err := mgm.Coll(new(models.Folder)).Aggregate(mgm.Ctx(), bson.A{bson.M{
		"$match": bson.M{
			"user_id": userId,
		},
	}, bson.M{
		"$lookup": bson.M{
			"from":         "notes",
			"localField":   "_id",
			"foreignField": "folder_id",
			"pipeline": bson.A{
				bson.M{
					"$count": "count",
				},
			},
			"as": "folder_notes",
		},
	}, bson.M{
		"$addFields": bson.M{
			"folder_id": bson.M{
				"$toString": "$_id",
			},
		},
	}, bson.M{
		"$project": bson.M{
			"_id":       1,
			"name":      1,
			"folder_id": 1,
			"note_count": bson.M{
				"$ifNull": bson.A{
					bson.M{
						"$arrayElemAt": bson.A{
							"$folder_notes.count",
							0,
						},
					},
					0,
				},
			},
		},
	}}); err != nil {
		return &responder.GenericError{
			Message: "Unable to fetch folders",
			Err:     err,
		}
	} else {
		for result.Next(mgm.Ctx()) {
			tempFolder := new(noteGetResponse)
			if err := result.Decode(tempFolder); err != nil {
				return &responder.GenericError{
					Message: "Unable to decode the result",
					Err:     err,
				}
			}
			folders = append(folders, tempFolder)
		}
	}
	logger.Dump(folders)
	return nil
}
