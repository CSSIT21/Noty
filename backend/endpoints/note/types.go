package note

import "time"

type notePostRequest struct {
	Title       string        `json:"title" validate:"required"`
	FolderId    string        `json:"folder_id"`
	NoteDetails []*NoteDetail `json:"note_details"`
	Tags        []string      `json:"tag"`
}

type NoteDetail struct {
	Type string `json:"type"`
	Data any    `json:"data" validate:"required"`
}

type NoteText struct {
	Detail string `json:"detail" validate:"required"`
}

type ReminderContent struct {
	Title       string    `json:"title" validate:"required,max=255"`
	Description string    `json:"description,omitempty"`
	RemindDate  time.Time `json:"remind_date,omitempty"`
	RemindTime  time.Time `json:"remind_time,omitempty"`
}

type noteDeleteRequest struct {
	NoteId string `json:"note_id"`
}

type noteFolderPatchRequest struct {
	FolderId string `json:"folder_id"`
	NoteId   string `json:"note_id"`
}

type noteDeleteReminderData struct {
	Data string `json:"reminder_id"`
}
