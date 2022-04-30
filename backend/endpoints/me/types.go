package me

type meGetResponse struct {
	Firstname string `json:"firstname"`
	Lastname  string `json:"lastname"`
	Email     string `json:"email"`
	PictureId string `json:"picture_id"`
	UserId    string `json:"user_id"`
	Notes     uint64 `json:"notes"`
	Folders   uint64 `json:"folders"`
	Tags      uint64 `json:"tags"`
	Reminders uint64 `json:"reminders"`
}

type mePatchNameRequest struct {
	Firstname string `json:"firstname"`
	Lastname  string `json:"lastname"`
}

type mePatchPasswordRequest struct {
	CurrentPassword string `json:"current_password"`
	NewPassword     string `json:"new_password" validate:"required,min=8,max=255"`
}
