package models

import "github.com/kamva/mgm/v3"

type Notes struct {
	mgm.DefaultModel `bson:",inline"`
	UserId           *string `json:"user_id" bson:"user_id"`
	Title            *string `json:"title" bson:"title"`
	FolderId         *string `json:"folder_id" bson:"folder_id"`
	NoteDetail       *[]any  `json:"note_detail" bson:"note_detail"`
}

type NoteText struct {
	Type   *string   `json:"type" bson:"type"`
	Detail *string   `json:"detail" bson:"detail"`
	Tag    *[]uint64 `json:"tag" bson:"tag"`
}

type ReminderContent struct {
	Type       *string `json:"type" bson:"type"`
	ReminderId *string `json:"reminder_id" bson:"reminder_id"`
}