package folder

type folderPostRequest struct {
	Name string `json:"name" validate:"required,max=40"`
}
