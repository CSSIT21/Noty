package mongo

import "github.com/kamva/mgm/v3"

type collectionList struct {
	User     *mgm.Collection
	Picture  *mgm.Collection
	Reminder *mgm.Collection
	Notes    *mgm.Collection
	Folder   *mgm.Collection
}

var Collections *collectionList
