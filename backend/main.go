package main

import (
	"math/rand"
	"time"

	"noty-backend/loaders/fiber"
	"noty-backend/loaders/mongo"
	"noty-backend/loaders/storage"
)

func main() {
	rand.Seed(time.Now().UnixNano())

	storage.Init()
	mongo.Init()
	fiber.Init()
}
