package models

import (
	"go.mongodb.org/mongo-driver/bson/primitive"
	"time"

	"github.com/kamva/mgm/v3"
)

type Reminder struct {
	mgm.DefaultModel `bson:",inline"`
	UserId           *primitive.ObjectID `json:"user_id" bson:"user_id"`
	Title            *string             `json:"title" bson:"title"`
	NoteId           *primitive.ObjectID `json:"note_id" bson:"note_id"`
	Description      *string             `json:"description" bson:"description"`
	RemindDate       *time.Time          `json:"remind_date" bson:"remind_date"`
}
