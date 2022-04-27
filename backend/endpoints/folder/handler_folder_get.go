package folder

import (
	"github.com/gofiber/fiber/v2"
)

func FolderGetHandler(c *fiber.Ctx) error {
	// * Parse user JWT token
	//token := c.Locals("user").(*jwt.Token)
	//claims := token.Claims.(*common.UserClaim)

	//folders := new([]models.Folder)
	//notes := new([]models.Notes)
	// Get all folders
	//if err := mgm.Coll(new(models.Folder)).SimpleAggregate(&folders, builder.Lookup(notes, "folders.note_id", "_id", "count"), bson.M{ operator.Count})
	return nil
}
