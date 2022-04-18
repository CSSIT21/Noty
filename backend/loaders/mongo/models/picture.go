package models

import "github.com/kamva/mgm/v3"

type Picture struct {
	mgm.DefaultModel `bson:"inline"`
	PictureUrl       string `json:"picture_url" bson:"picture_url"`
}
