package folder

import (
	"github.com/gofiber/fiber/v2"
	"github.com/kamva/mgm/v3"
	"noty-backend/loaders/mongo/models"
	"noty-backend/types/responder"
	"noty-backend/utils/text"
)

// FolderDeleteHandler
// @ID folder.delete
// @Summary Delete folder
// @Description Delete folder
// @Tags folder
// @Accept json
// @Produce json
// @Param payload body folderDeleteRequest true "folder.folderDeleteRequest"
// @Success 200 {object} folderDeleteRequest
// @Failure 400 {object} responder.ErrorResponse
// @Router /folder/delete [delete]
func FolderDeleteHandler(c *fiber.Ctx) error {
	// * Parse Body
	var body folderDeleteRequest
	if err := c.BodyParser(&body); err != nil {
		return &responder.GenericError{
			Message: "Unable to parse body",
			Err:     err,
		}
	}

	// * Validate body
	if err := text.Validate.Struct(body); err != nil {
		return err
	}

	// * Find the folder
	folder := new(models.Folder)
	if err := mgm.Coll(folder).FindByID(body.FolderId, folder); err != nil {
		return &responder.GenericError{
			Message: "Unable to find the folder",
			Err:     err,
		}
	}

	// * Delete the folder
	if err := mgm.Coll(folder).Delete(folder); err != nil {
		return &responder.GenericError{
			Message: "Unable to delete the folder",
			Err:     err,
		}
	}

	return c.JSON(&responder.InfoResponse{
		Success: true,
		Info:    "Delete folder successful",
	})
}
