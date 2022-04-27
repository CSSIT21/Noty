package register

type registerRequest struct {
	Email     string `json:"email" validate:"email"`
	Password  string `json:"password" validate:"required,max=255,min=8"`
	Firstname string `json:"firstname"`
	Lastname  string `json:"lastname"`
}

type registerResponse struct {
	Token string `json:"token"`
}
