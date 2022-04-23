package folder

import (
	"github.com/gofiber/fiber/v2"
	"github.com/kamva/mgm/v3"
	"noty-backend/loaders/mongo/models"
	"noty-backend/types/responder"
	"noty-backend/utils/text"
)

// FolderPatchHandler
// @ID folder.patch
// @Summary Patch folder
// @Description Patch folder
// @Tags folder
// @Accept json
// @Produce json
// @Param payload body folderPatchRequest true "folder.folderPatchRequest"
// @Success 200 {object} folderPatchRequest
// @Failure 400 {object} responder.ErrorResponse
// @Router /folder/edit [patch]
func FolderPatchHandler(c *fiber.Ctx) error {
	// * Parse Body
	var body folderPatchRequest
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
	} else {
		folder.Name = &body.NewName
	}

	// * Update folder name
	if err := mgm.Coll(folder).Update(folder); err != nil {
		return &responder.GenericError{
			Message: "Unable to change the name of folder",
			Err:     err,
		}
	}

	return c.JSON(&responder.InfoResponse{
		Success: true,
		Info:    "Change the name of folder successful",
	})
}
