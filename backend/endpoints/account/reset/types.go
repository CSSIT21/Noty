package reset

type resetRequest struct {
	Email string `json:"email" verify:"email"`
}
