package folder

type folderPostRequest struct {
	Name string `json:"name" validate:"required,max=40"`
}

type folderPatchRequest struct {
	FolderId string `json:"folder_id" validate:"required"`
	NewName  string `json:"new_name" validate:"required,max=40"`
}

type folderDeleteRequest struct {
	FolderId string `json:"folder_id" validate:"required"`
}
