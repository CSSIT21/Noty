package config

type config struct {
	Environment environment
	LogLevel    uint32

	Address      string
	ServerHeader string
	Cors         []string

	JwtSecret       string
	RecaptchaSecret string

	MySqlDsn     string
	MySqlMigrate bool

	InternalIps   []string
	InternalAuths []struct {
		Username string
		Password string
	}

	MsJwtPublicKey  string
	MsJwtPrivateKey string
}
