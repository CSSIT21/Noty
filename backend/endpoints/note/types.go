package note

type notePostRequest struct {
	Title    string `json:"title"`
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
	FolderId  string `json:"folder_id" bson:"folder_id"`
	Name      string `json:"name" bson:"name"`
	NoteCount uint64 `json:"note_count" bson:"note_count"`
}
