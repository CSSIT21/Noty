package models

import "github.com/kamva/mgm/v3"

type User struct {
	mgm.Model
	mgm.DefaultModel `bson:"inline"`
	Firstname        string `json:"firstname" bson:"firstname"`
	Lastname         string `json:"lastname" bson:"lastname"`
	Email            string `json:"email" bson:"email"`
	Password         string `json:"password" bson:"password"`
	PictureId        uint64 `json:"picture_id" bson:"picture_id"`
}
