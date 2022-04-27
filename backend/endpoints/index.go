package endpoints

import (
	"github.com/gofiber/fiber/v2"
	editAccount "noty-backend/endpoints/edit_account"
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

	// * Edit Account
	editAccountHandler := router.Group("account/edit", middlewares.Jwt)
	editAccountHandler.Patch("name", editAccount.EditNamePatchHandler)
	editAccountHandler.Patch("password", editAccount.ChangePasswordPatchHandler)
	// * Reminder
	reminderHandler := router.Group("reminder/", middlewares.Jwt)
	reminderHandler.Post("add", reminder.ReminderPostHandler)
	reminderHandler.Patch("edit", reminder.ReminderPatchHandler)
	reminderHandler.Delete("delete", reminder.ReminderDeleteHandler)

	// * Folder
	folderHandler := router.Group("folder/", middlewares.Jwt)
	folderHandler.Post("add", folder.FolderPostHandler)
	folderHandler.Patch("edit", folder.FolderPatchHandler)
	folderHandler.Delete("delete", folder.FolderDeleteHandler)
}
