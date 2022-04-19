package models

import (
	"github.com/kamva/mgm/v3"
)

type Folder struct {
	mgm.DefaultModel `bson:",inline"`
	UserId           *uint64           `json:"user_id" bson:"user_id"`
	Folders          *FolderCollection `json:"folders" bson:"folders"`
}

type FolderCollection struct {
	mgm.DefaultModel `bson:",inline"`
	Name             *string   `json:"name" bson:"name"`
	NotesId          *[]uint64 `json:"notes_id" bson:"notes_id"`
}
