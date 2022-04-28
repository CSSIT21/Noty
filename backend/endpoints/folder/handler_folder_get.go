package folder

import (
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"github.com/kamva/mgm/v3"
	"go.mongodb.org/mongo-driver/bson"
	"noty-backend/loaders/mongo/models"
	"noty-backend/types/common"
	"noty-backend/types/responder"
)

// FolderGetHandler
// @ID folder.get
// @Summary Get all folders
// @Description List all folders
// @Tags folder
// @Accept json
// @Produce json
// @Success 200 {object} folder.folderGetResponse
// @Failure 400 {object} responder.ErrorResponse
// @Router /folder/list [get]
func FolderGetHandler(c *fiber.Ctx) error {
	// * Parse user JWT token
	token := c.Locals("user").(*jwt.Token)
	claims := token.Claims.(*common.UserClaim)

	var folders []models.Folder

	// * Get all folders
	if err := mgm.Coll(&models.Folder{}).SimpleFind(&folders, bson.M{
		"user_id": claims.UserId,
	}); err != nil {
		return &responder.GenericError{
			Message: "Unable to find folders",
			Err:     err,
		}
	}

	var foldersTemp []folderGetResponse

	// * Append results into foldersTemp array
	for _, detail := range folders {
		foldersTemp = append(foldersTemp, folderGetResponse{
			FolderId: detail.ID.Hex(),
			Name:     *detail.Name,
		})
	}

	return c.JSON(&responder.InfoResponse{
		Success: true,
		Data:    foldersTemp,
	})
}
