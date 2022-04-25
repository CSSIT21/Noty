package reminder

import "time"

type reminderPostRequest struct {
	Title       string    `json:"title" validate:"required,max=255"`
	NoteId      string    `json:"note_id"`
	Description string    `json:"description,omitempty"`
	RemindDate  time.Time `json:"remind_date,omitempty"`
	RemindTime  time.Time `json:"remind_time,omitempty"`
}

type reminderPatchRequest struct {
	ReminderId  string    `json:"reminder_id" validate:"required"`
	Title       string    `json:"title" validate:"required,max=255"`
	NoteId      string    `json:"note_id"`
	Description string    `json:"description,omitempty"`
	RemindDate  time.Time `json:"remind_date,omitempty"`
	RemindTime  time.Time `json:"remind_time,omitempty"`
}
