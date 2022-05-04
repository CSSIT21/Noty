package models

import (
	"github.com/kamva/mgm/v3"
)

type User struct {
	mgm.DefaultModel `bson:",inline"`
	Firstname        *string `json:"firstname" bson:"firstname"`
	Lastname         *string `json:"lastname" bson:"lastname"`
	Email            *string `json:"email" bson:"email"`
	AvatarUrl        *string `json:"avatar_url" bson:"avatar_url"`
	Password         *string `json:"password" bson:"password"`
	ResetToken       *string `json:"reset_token" bson:"reset_token"`
}
