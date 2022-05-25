package me

import (
	"fmt"
	"image"
	"os"
	"path"
	"path/filepath"

	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"github.com/kamva/mgm/v3"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"

	"noty-backend/loaders/mongo/models"
	"noty-backend/loaders/storage"
	"noty-backend/types/common"
	"noty-backend/types/responder"
	"noty-backend/utils/text"
)

// MeAvatarPostHandler
// @ID me.avatar.patch
// @Summary Update avatar image
// @Description Update avatar image
// @Tags me
// @Accept json
// @Produce json
// @Param ext formData string true "ext"
// @Param image formData string true "image"
// @Success 200 {object} responder.InfoResponse
// @Failure 400 {object} responder.ErrorResponse
// @Router /me/avatar [patch]
func MeAvatarPostHandler(c *fiber.Ctx) error {
	// * Parse user JWT token
	token := c.Locals("user").(*jwt.Token)
	claims := token.Claims.(*common.UserClaim)

	// * Parse form parameters
	ext := c.FormValue("ext")

	// * Parse multipart file parameter
	fileHeader, err := c.FormFile("image")
	if err != nil {
		return &responder.GenericError{
			Message: "Unable to parse image file",
			Err:     err,
		}
	}

	// * Open multipart to file
	file, err := fileHeader.Open()
	if err != nil {
		return &responder.GenericError{
			Message: "Unable to parse image file",
			Err:     err,
		}
	}

	// * Decode image
	img, _, err := image.Decode(file)
	if err != nil {
		return &responder.GenericError{
			Message: "Unable to decode image",
			Err:     err,
		}
	}

	// * Parse ObjectId
	userId, err := primitive.ObjectIDFromHex(*claims.UserId)
	if err != nil {
		return err
	}

	// * Assign file path
	filePath := path.Join(storage.RootDir, *claims.UserId)
	fileSalt := *text.GenerateString(text.GenerateStringSet.Num, 6)

	// * Check for existing avatar image for the user
	matches, err := filepath.Glob(filePath + ".*")
	if err != nil {
		return &responder.GenericError{
			Message: "Unable to check for file existent",
			Err:     err,
		}
	}

	// * Remove old user avatar
	for _, match := range matches {
		if err = os.Remove(match); err != nil {
			return &responder.GenericError{
				Message: "Unable to remove old avatar",
				Err:     err,
			}
		}
	}

	// * Save image to file
	savingFile, err := os.Create(filePath + "." + fileSalt + ".jpeg")
	if err != nil {
		return &responder.GenericError{
			Message: "Unable to create an image file",
			Err:     err,
		}
	}
	defer savingFile.Close()

	// * Update user record
	if _, err := mgm.Coll(new(models.User)).UpdateByID(
		mgm.Ctx(),
		userId,
		bson.M{"$set": bson.M{
			"avatar_url": fmt.Sprintf("/static/%s.%s.jpeg", filePath, fileSalt),
		}},
	); err != nil {
		return &responder.GenericError{
			Message: "Unable to fetch user account",
			Err:     err,
		}
	}

	return c.JSON(&responder.InfoResponse{
		Success: true,
		Info:    "Avatar has been changed",
	})
}
