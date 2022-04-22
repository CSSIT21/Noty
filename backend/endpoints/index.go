package endpoints

import (
	"github.com/gofiber/fiber/v2"
	"noty-backend/loaders/fiber/middlewares"

	accountLogin "noty-backend/endpoints/account/login"
	accountRegister "noty-backend/endpoints/account/register"
	reminder "noty-backend/endpoints/reminder"
)

func Init(router fiber.Router) {
	// * Account
	account := router.Group("account/")
	account.Post("login", accountLogin.LoginHandler)
	account.Post("register", accountRegister.RegisterHandler)

	// * Reminder
	reminderHandler := router.Group("reminder/", middlewares.Jwt)
	reminderHandler.Post("add", reminder.ReminderPostHandler)
}