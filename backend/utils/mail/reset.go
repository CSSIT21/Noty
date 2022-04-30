package mail

import (
	"bytes"
	"net/smtp"

	"noty-backend/types/responder"
	"noty-backend/utils/config"
)

func SendPasswordResetMail(name string, pin string, email string) *responder.GenericError {
	var body bytes.Buffer

	body.Write([]byte("Subject: Noty password reset" +
		"\nFrom: Noty System <" + config.C.SmtpUser + ">" +
		"\nTo: " + name + " <" + email + ">" +
		"\nMIME-Version: 1.0" +
		"\nContent-Type: text/html; charset='UTF-8';\n"))

	if err := passwordResetTemplate.Execute(&body, map[string]any{
		"name": name,
		"pin":  pin,
	}); err != nil {
		return &responder.GenericError{
			Message: "Unable to generate verification email",
		}
	}

	if err := smtp.SendMail(
		config.C.SmtpHost,
		auth,
		config.C.SmtpUser,
		[]string{email},
		body.Bytes(),
	); err != nil {
		return &responder.GenericError{
			Message: "Unable to send email address",
			Err:     err,
		}
	}

	return nil
}
