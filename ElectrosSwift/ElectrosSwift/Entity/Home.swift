import Foundation

// MARK: - HomeData
struct HomeData: Codable {
    let categories: [Category]
}

// MARK: - Category
struct Category: Codable {
    let title: String
    var items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let identifier: String
    let itemName: String
    let cost: Float
    let details: String
    let imageNames: [String]
    var isFavorite: Bool
    let availableColors: [String]
}

// MARK: - ShoppingCart
struct ShoppingCart: Codable {
    var quantity: Int
    let item: Item
}

// Sample Data
let sampleProducts = [
    Item(identifier: "1", itemName: "Product A", cost: 19.99, details: "Description for Product A", imageNames: ["imageA1", "imageA2"], isFavorite: false, availableColors: ["Red", "Blue"]),
    Item(identifier: "2", itemName: "Product B", cost: 29.99, details: "Description for Product B", imageNames: ["imageB1", "imageB2"], isFavorite: true, availableColors: ["Green", "Yellow"]),
    Item(identifier: "3", itemName: "Product C", cost: 39.99, details: "Description for Product C", imageNames: ["imageC1", "imageC2"], isFavorite: false, availableColors: ["Black", "White"])
]

let sampleCategory = Category(title: "Featured Products", items: sampleProducts)

let homeData = HomeData(categories: [sampleCategory])

// Example of adding a product to the cart
var cart = ShoppingCart(quantity: 2, item: sampleProducts[0])

print(homeData)
print(cart)
