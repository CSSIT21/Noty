package endpoints

import (
	"github.com/gofiber/fiber/v2"
	"noty-backend/endpoints/folder"
	"noty-backend/loaders/fiber/middlewares"

	accountLogin "noty-backend/endpoints/account/login"
	accountRegister "noty-backend/endpoints/account/register"
	"noty-backend/endpoints/reminder"
)

func Init(router fiber.Router) {
	// * Account
	account := router.Group("account/")
	account.Post("login", accountLogin.LoginHandler)
	account.Post("register", accountRegister.RegisterHandler)

	// * Reminder
	reminderHandler := router.Group("reminder/", middlewares.Jwt)
	reminderHandler.Post("add", reminder.ReminderPostHandler)

	// * Folder
	folderHandler := router.Group("folder/", middlewares.Jwt)
	folderHandler.Post("add", folder.FolderPostReminder)
	folderHandler.Patch("edit", folder.FolderPatchHandler)
}
