package models

import (
	"github.com/kamva/mgm/v3"
)

type Folder struct {
	mgm.DefaultModel `bson:",inline"`
	UserId           *uint64 `json:"user_id" bson:"user_id"`
	Name             *string `json:"name" bson:"name"`
}
