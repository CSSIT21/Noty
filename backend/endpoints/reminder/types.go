package reminder

import "time"

type reminderPostRequest struct {
	Title       string    `json:"title"`
	NoteId      string    `json:"note_id"`
	Description string    `json:"description,omitempty"`
	RemindDate  time.Time `json:"remind_date,omitempty"`
	RemindTime  time.Time `json:"remind_time,omitempty"`
}
