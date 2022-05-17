package reset

type sendRequest struct {
	Email string `json:"email" validate:"email"`
}

type verifyRequest struct {
	Email string `json:"email" validate:"email"`
	Pin   string `json:"pin" validate:"numeric,len=6"`
}

type resetPasswordRequest struct {
	Email    string `json:"email" validate:"email"`
	Password string `json:"password" validate:"required,max=255,min=8"`
}
