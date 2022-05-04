package models

import (
	"github.com/kamva/mgm/v3"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

type Folder struct {
	mgm.DefaultModel `bson:",inline"`
	UserId           *primitive.ObjectID `json:"user_id" bson:"user_id"`
	Name             *string             `json:"name" bson:"name"`
}
