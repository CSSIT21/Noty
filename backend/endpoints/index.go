package endpoints

import (
	"github.com/gofiber/fiber/v2"

	"noty-backend/endpoints/folder"
	"noty-backend/endpoints/me"
	"noty-backend/endpoints/note"
	"noty-backend/endpoints/tag"
	"noty-backend/loaders/fiber/middlewares"

	accountLogin "noty-backend/endpoints/account/login"
	accountRegister "noty-backend/endpoints/account/register"
	accountReset "noty-backend/endpoints/account/reset"
	"noty-backend/endpoints/reminder"
)

func Init(router fiber.Router) {
	// * Account
	account := router.Group("account/")
	account.Post("login", accountLogin.LoginHandler)
	account.Post("register", accountRegister.RegisterHandler)
	account.Post("reset/send", accountReset.SendHandler)
	account.Post("reset/verify", accountReset.VerifyHandler)

	// * Reminder
	reminderHandler := router.Group("reminder/", middlewares.Jwt)
	reminderHandler.Get("info", reminder.ReminderGetHandler)
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
	noteHandler.Get("info", note.NoteGetHandler)
	noteHandler.Get("info/id", note.NoteGetByIdHandler)
	noteHandler.Post("add", note.NotePostHandler)
	noteHandler.Patch("edit", note.NotePatchHandler)
	noteHandler.Delete("delete", note.NoteDeleteHandler)
	noteHandler.Patch("move", note.NoteFolderPatchHandler)

	// * Me
	meHandler := router.Group("me/", middlewares.Jwt)
	meHandler.Get("info", me.MeGetHandler)
	meHandler.Patch("edit/name", me.MePatchNameHandler)
	meHandler.Patch("edit/password", me.MePatchPasswordHandler)

	// * Tag
	tagHandler := router.Group("tag/", middlewares.Jwt)
	tagHandler.Get("list", tag.TagGetHandler)
}
