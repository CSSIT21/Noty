package models

import (
	"github.com/kamva/mgm/v3"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

type User struct {
	mgm.DefaultModel `bson:",inline"`
	Firstname        *string             `json:"firstname" bson:"firstname"`
	Lastname         *string             `json:"lastname" bson:"lastname"`
	Email            *string             `json:"email" bson:"email"`
	Password         *string             `json:"password" bson:"password"`
	PictureId        *primitive.ObjectID `json:"picture_id" bson:"picture_id"`
	ResetToken       *string             `json:"reset_token" bson:"reset_token"`
}
