package endpoints

import (
	"github.com/gofiber/fiber/v2"

	accountLogin "noty-backend/endpoints/account/login"
	accountRegister "noty-backend/endpoints/account/register"
)

func Init(router fiber.Router) {
	// * Account
	account := router.Group("account/")
	account.Post("login", accountLogin.LoginHandler)
	account.Post("register", accountRegister.RegisterHandler)
}
