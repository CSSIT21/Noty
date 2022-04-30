package mail

import (
	"html/template"
	"net/smtp"
	"strings"

	"noty-backend/utils/config"
)

var auth smtp.Auth
var passwordResetTemplate *template.Template

func init() {
	auth = smtp.PlainAuth("", config.C.SmtpUser, config.C.SmtpPass, strings.Split(config.C.SmtpHost, ":")[0])

	passwordResetTemplate = template.Must(template.New("template_password_reset").Parse(passwordResetEmbed))
}
