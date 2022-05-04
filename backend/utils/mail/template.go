package mail

import _ "embed"

//go:embed template_password_reset.html
var passwordResetEmbed string

//go:embed template_password_changed.html
var passwordChangedEmbed string
