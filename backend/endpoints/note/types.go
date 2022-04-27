package note

import "time"

type notePostRequest struct {
	Title       string        `json:"title"`
	FolderId    string        `json:"folder_id"`
	NoteDetails []*NoteDetail `json:"note_details"`
}

type NoteDetail struct {
	Type string `json:"type"`
	Data any    `json:"data"`
}

type NoteText struct {
	Detail string `json:"detail"`
}

type ReminderContent struct {
	Type        string    `json:"type"`
	Title       string    `json:"title" validate:"required,max=255"`
	Description string    `json:"description,omitempty"`
	RemindDate  time.Time `json:"remind_date,omitempty"`
	RemindTime  time.Time `json:"remind_time,omitempty"`
}
