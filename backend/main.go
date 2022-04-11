package main

import (
	"math/rand"
	"time"

	"noty-backend/loaders/fiber"
)

func main() {
	rand.Seed(time.Now().UnixNano())

	fiber.Init()
}
