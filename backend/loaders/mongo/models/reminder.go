package models

import (
	"github.com/kamva/mgm/v3"
	"time"
)

type Reminder struct {
	mgm.DefaultModel `bson:"inline"`
	UserId           *uint64    `json:"user_id" bson:"user_id"`
	Title            *string    `json:"title" bson:"title"`
	Description      *string    `json:"description" bson:"description"`
	RemindDate       *time.Time `json:"remind_date" bson:"remind_date"`
	RemindTime       *time.Time `json:"remind_time" bson:"remind_time"`
}
