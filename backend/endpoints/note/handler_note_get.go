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

// NoteGetHandler
// @ID note.get
// @Summary Get all notes and folders
// @Description Get all notes and folders
// @Tags note
// @Accept json
// @Produce json
// @Success 200 {object} note.noteGetResponse
// @Failure 400 {object} responder.ErrorResponse
// @Router /note/info [get]
func NoteGetHandler(c *fiber.Ctx) error {
	// * Parse user JWT token
	token := c.Locals("user").(*jwt.Token)
	claims := token.Claims.(*common.UserClaim)

	userId, _ := primitive.ObjectIDFromHex(*claims.UserId)

	// * Fetch folders and count the numbers notes in folders
	var folders []*noteGetFoldersResponse
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
			tempFolder := new(noteGetFoldersResponse)
			if err := result.Decode(tempFolder); err != nil {
				return &responder.GenericError{
					Message: "Unable to decode the result",
					Err:     err,
				}
			}
			folders = append(folders, tempFolder)
		}
	}

	// * Fetch all notes
	var notes []*noteGetNotesResponse
	if result, err := mgm.Coll(&models.Notes{}).Find(mgm.Ctx(), bson.M{
		"user_id": userId,
	}); err != nil {
		return &responder.GenericError{
			Message: "Unable to fetch notes",
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
			tempNoteResponse := &noteGetNotesResponse{
				NoteId:    tempNote.ID.Hex(),
				Title:     *tempNote.Title,
				CreatedAt: tempNote.CreatedAt,
				Tag:       tempNote.Tags,
			}
			for _, detail := range tempNote.Details {
				if *detail.Type == "reminder" {
					tempNoteResponse.HasReminder = true
				}
			}
			notes = append(notes, tempNoteResponse)
		}
	}

	return c.JSON(&responder.InfoResponse{
		Success: true,
		Data: &noteGetResponse{
			Folders: folders,
			Notes:   notes,
		},
	})
}
