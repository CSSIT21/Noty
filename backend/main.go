package main

import (
	"math/rand"
	"time"

	"noty-backend/loaders/fiber"
	"noty-backend/loaders/mongo"
)

func main() {
	rand.Seed(time.Now().UnixNano())

	mongo.Init()
	fiber.Init()
}
