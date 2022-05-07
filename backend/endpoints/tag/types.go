package tag

import "time"

type tagAllGetResponse struct {
	TagsName []string     `json:"tags_name"`
	TagsList []notesInTag `json:"tags_list"`
}

type notesInTag struct {
	Name  string       `json:"name"`
	Notes []noteObject `json:"notes"`
}

type noteObject struct {
	Title  string   `json:"title"`
	Tags   []string `json:"tags"`
	NoteId string   `json:"note_id"`
}

type noteSearchPost struct {
	TagName string `json:"tag_name"`
}

type noteResponse struct {
	NoteId    string    `json:"note_id"`
	Title     string    `json:"title"`
	Tags      []string  `json:"tags"`
	UpdatedAt time.Time `json:"updated_at"`
}
