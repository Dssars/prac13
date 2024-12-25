package models

// Cart представляет структуру корзины
type Cart1 struct {
	ProductID   int     `db:"product_id" json:"product_id"`
	Name        string  `db:"name" json:"name"`
	Description string  `db:"description" json:"description"`
	Price       float64 `db:"price" json:"price"`
	ImageURL    string  `db:"image_url" json:"image_url"`
	Quantity    int     `db:"quantity" json:"quantity"`
}
