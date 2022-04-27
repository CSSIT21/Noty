package common

type UserClaim struct {
	UserId *string `json:"user_id"`
}

func (T *UserClaim) Valid() error {
	return nil
}
