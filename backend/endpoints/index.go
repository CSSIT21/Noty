package endpoints

import (
	"github.com/gofiber/fiber/v2"
	"noty-backend/endpoints/folder"
	"noty-backend/endpoints/me"
	"noty-backend/endpoints/note"
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
	editAccountHandler.Patch("name", me.MePatchNameHandler)
	editAccountHandler.Patch("password", me.MePatchPasswordHandler)

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
	folderHandler.Get("list", folder.FolderGetHandler)

	// * Note
	noteHandler := router.Group("note/", middlewares.Jwt)
	noteHandler.Post("add", note.NotePostHandler)

	// * Me
	meHandler := router.Group("me/", middlewares.Jwt)
	meHandler.Get("info", me.MeGetHandler)
}
