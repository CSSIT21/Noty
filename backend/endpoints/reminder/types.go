package reminder

import (
	"go.mongodb.org/mongo-driver/bson/primitive"
	"noty-backend/loaders/mongo/models"
	"time"
)

type reminderPostRequest struct {
	Title       string    `json:"title" validate:"required,max=255"`
	NoteId      string    `json:"note_id"`
	Description string    `json:"description,omitempty"`
	RemindDate  time.Time `json:"remind_date,omitempty"`
}

type reminderPostResponse struct {
	ReminderId string `json:"reminder_id" validate:"required"`
}

type reminderPatchRequest struct {
	ReminderId  string    `json:"reminder_id" validate:"required"`
	Title       string    `json:"title" validate:"required,max=255"`
	NoteId      string    `json:"note_id"`
	Description string    `json:"description,omitempty"`
	RemindDate  time.Time `json:"remind_date,omitempty"`
}

type reminderDeleteRequest struct {
	ReminderId string `json:"reminder_id" validate:"required"`
}

type reminderGetResponse struct {
	IndependentReminders []*independentReminders `json:"independent_reminders"`
	NotesReminders       []*noteAllGetDecoded    `json:"notes_reminders"`
}

type independentReminders struct {
	ReminderId  string    `json:"reminder_id"`
	Title       string    `json:"title"`
	Description string    `json:"description"`
	RemindDate  time.Time `json:"remind_date"`
}

type noteAllGetDecode struct {
	NoteId    primitive.ObjectID `json:"note_id" bson:"_id"`
	Title     string             `json:"title"`
	Reminders []models.Reminder  `json:"reminders"`
}

type noteAllGetDecoded struct {
	NoteId    string            `json:"note_id"`
	Title     string            `json:"title"`
	Reminders []models.Reminder `json:"reminders"`
}
