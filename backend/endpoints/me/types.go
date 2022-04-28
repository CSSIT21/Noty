package me

type meGetResponse struct {
	Firstname string `json:"firstname"`
	Lastname  string `json:"lastname"`
	Email     string `json:"email"`
	PictureId string `json:"picture_id"`
	UserId    string `json:"user_id"`
}

type mePatchNameRequest struct {
	Firstname string `json:"firstname"`
	Lastname  string `json:"lastname"`
}

type mePatchPasswordRequest struct {
	CurrentPassword string `json:"current_password"`
	NewPassword     string `json:"new_password" validate:"required,min=8,max=255"`
}
