package main

import (
	"log"
	"shopApi/db"
	"shopApi/handlers"
	"time"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
)

func main() {
	// Подключаемся к базе данных
	db, err := db.ConnectDB()
	if err != nil {
		log.Fatal("Ошибка подключения к БД:", err)
	}

	router := gin.Default()

	// Настройка CORS
	router.Use(cors.New(cors.Config{
		AllowOrigins:     []string{"*"}, // Замените * на нужные вам источники
		AllowMethods:     []string{"GET", "POST", "PUT", "DELETE"},
		AllowHeaders:     []string{"Origin", "Content-Type", "Accept"},
		ExposeHeaders:    []string{"Content-Length"},
		AllowCredentials: true,
		MaxAge:           12 * time.Hour,
	}))

	// Роуты для продуктов
	router.GET("/products", handlers.GetProducts(db))
	router.GET("/products/:id", handlers.GetProduct(db))
	router.POST("/products", handlers.CreateProduct(db))
	router.PUT("/products/:id", handlers.UpdateProduct(db))
	router.DELETE("/products/:id", handlers.DeleteProduct(db))

	// Роуты для корзины
	router.GET("/carts/:userId", handlers.GetCart(db))
	router.POST("/carts/:userId", handlers.AddToCart(db))
	router.DELETE("/carts/:userId/:productId", handlers.RemoveFromCart(db))
	router.PUT("/carts/:userId/:productId/plus", handlers.UpdateCartPlus(db))
	router.PUT("/carts/:userId/:productId/minus", handlers.UpdateCartMinus(db))

	// Роуты для избранного
	router.GET("/favorites/:userId", handlers.GetFavorites(db))
	router.POST("/favorites/:userId", handlers.AddToFavorites(db))
	router.DELETE("/favorites/:userId/:productId", handlers.RemoveFromFavorites(db))

	// Роуты для заказов
	router.GET("/orders/:id", handlers.GetOrders(db))
	router.POST("/orders/:user_id", handlers.CreateOrder(db))

	// Запуск сервера
	router.Run(":8080")
}
