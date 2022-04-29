package mail

import (
	"net/smtp"
	"strings"

	"noty-backend/utils/config"
)

var SmtpAuth smtp.Auth

func init() {
	SmtpAuth = smtp.PlainAuth("", config.C.SmtpUser, config.C.SmtpPass, strings.Split(config.C.SmtpHost, ":")[0])
}
