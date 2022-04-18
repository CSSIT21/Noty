package signing

import (
	"github.com/golang-jwt/jwt/v4"
	"noty-backend/types/common"
	"noty-backend/types/responder"
	"noty-backend/utils/config"
)

func SignJwt(claim *common.UserClaim) (string, *responder.GenericError) {
	// * Create token
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claim)

	// * Generate signed token string
	if signedToken, err := token.SignedString([]byte(config.C.JwtSecret)); err != nil {
		return "", &responder.GenericError{
			Message: "Unable to sign JWT token",
			Err:     err,
		}
	} else {
		return signedToken, nil
	}
}
