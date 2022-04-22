package models

import (
	"time"

	"github.com/kamva/mgm/v3"
)

type Reminder struct {
	mgm.DefaultModel `bson:",inline"`
	UserId           *string    `json:"user_id" bson:"user_id"`
	Title            *string    `json:"title" bson:"title"`
	NoteId           *string    `json:"note_id" bson:"note_id"`
	Description      *string    `json:"description" bson:"description"`
	RemindDate       *time.Time `json:"remind_date" bson:"remind_date"`
	RemindTime       *time.Time `json:"remind_time" bson:"remind_time"`
}
