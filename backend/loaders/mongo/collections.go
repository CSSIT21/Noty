package mongo

import "github.com/kamva/mgm/v3"

type collectionList struct {
	User *mgm.Collection
}

var Collections *collectionList
