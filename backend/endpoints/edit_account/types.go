package edit_account

type editNameRequest struct {
	Firstname string `json:"firstname"`
	Lastname  string `json:"lastname"`
}

type changePasswordRequest struct {
	CurrentPassword string `json:"current_password"`
	NewPassword     string `json:"new_password" validate:"required,min=8,max=255"`
}
