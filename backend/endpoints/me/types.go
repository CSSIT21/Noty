package me

type meGetResponse struct {
	Firstname string `json:"firstname"`
	Lastname  string `json:"lastname"`
	Email     string `json:"email"`
	PictureId string `json:"picture_id"`
	UserId    string `json:"user_id"`
}
