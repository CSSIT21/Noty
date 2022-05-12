package mongo

import (
	"time"

	"github.com/kamva/mgm/v3"
	"github.com/sirupsen/logrus"
	"go.mongodb.org/mongo-driver/mongo/options"

	"noty-backend/loaders/mongo/models"
	"noty-backend/utils/config"
	"noty-backend/utils/logger"
)

func Init() {
	// Initialize Mongo and MGM configuration
	if err := mgm.SetDefaultConfig(
		&mgm.Config{
			CtxTimeout: 12 * time.Second,
		},
		config.C.MongoDbName,
		options.Client().ApplyURI(config.C.MongoUri),
	); err != nil {
		logger.Log(logrus.Fatal, "UNABLE TO LOAD MGM: "+err.Error())
	}

	// Initialize models
	Collections = &collectionList{
		User:     mgm.Coll(new(models.User)),
		Reminder: mgm.Coll(new(models.Reminder)),
		Notes:    mgm.Coll(new(models.Notes)),
		Folder:   mgm.Coll(new(models.Folder)),
	}
}
