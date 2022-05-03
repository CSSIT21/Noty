package note

import "time"

type notePostRequest struct {
	FolderId string `json:"folder_id"`
}

type notePostResponse struct {
	NoteId string `json:"note_id"`
}

type notePatchRequest struct {
	Title       string        `json:"title" validate:"required"`
	FolderId    string        `json:"folder_id"`
	NoteId      string        `json:"note_id"`
	NoteDetails []*NoteDetail `json:"note_details"`
}

type NoteDetail struct {
	Type string `json:"type"`
	Data any    `json:"data"`
}

type NoteContent struct {
	Detail string `json:"detail"`
}

type ReminderContent struct {
	ReminderId string `json:"reminder_id"`
}

type noteDeleteRequest struct {
	NoteId string `json:"note_id"`
}

type noteFolderPatchRequest struct {
	FolderId string `json:"folder_id"`
	NoteId   string `json:"note_id"`
}

type noteGetResponse struct {
	Folders []*noteGetFoldersResponse `json:"folders"`
	Notes   []*noteGetNotesResponse   `json:"notes"`
}

type noteGetFoldersResponse struct {
	FolderId  string `json:"folder_id" bson:"folder_id"`
	Name      string `json:"name" bson:"name"`
	NoteCount uint64 `json:"note_count" bson:"note_count"`
}

type noteGetNotesResponse struct {
	NoteId      string    `json:"note_id"`
	Title       string    `json:"title"`
	UpdatedAt   time.Time `json:"updated_at"`
	Tags        []string  `json:"tag"`
	HasReminder bool      `json:"has_reminder"`
}

type noteGetByIdRequest struct {
	NoteId string `json:"note_id"`
}

type noteGetByFolderId struct {
	FolderId string `json:"folder_id"`
}
