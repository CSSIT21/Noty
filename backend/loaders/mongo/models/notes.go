package models

import (
	"github.com/kamva/mgm/v3"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

type Notes struct {
	mgm.DefaultModel `bson:",inline"`
	UserId           *string             `json:"user_id" bson:"user_id"`
	Title            *string             `json:"title" bson:"title"`
	FolderId         *primitive.ObjectID `json:"folder_id" bson:"folder_id"`
	Tags             []string            `json:"tags" bson:"tags"`
	Details          []*NoteDetail       `json:"details" bson:"details"`
}

type NoteDetail struct {
	Type *string `json:"type" bson:"type"`
	Data any     `json:"data" bson:"data"`
}

type NoteText struct {
	Detail *string `json:"detail" bson:"detail"`
}

type ReminderContent struct {
	ReminderId *primitive.ObjectID `json:"reminder_id" bson:"reminder_id"`
}
