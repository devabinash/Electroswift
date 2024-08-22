import Foundation

/**
 The `DetailsProductViewModel` class is responsible for handling the business logic 
 associated with viewing, saving, and adding products to the cart in the product details screen.
 It interacts with `UserDefaultsManagement` to persist data related to viewed, saved, and carted products.
 */
class DetailsProductViewModel {
    // MARK: - Constants
    /**
     `userDefaultsManager` is an instance of `UserDefaultsManagement` used to handle saving 
     and retrieving products from UserDefaults. This class acts as an interface for accessing
     locally stored data.
     */
    let userDefaultsManager = UserDefaultsManagement()
    
    // MARK: - Init
    public init() {
    }
    
    // MARK: - Methods
    
    /**
     Marks a product as viewed by adding it to the list of viewed products stored in UserDefaults.
     
     - Parameter product: The product to mark as viewed.
     - Returns: A boolean indicating whether the product was marked as viewed for the first time.
     
     This method checks if the product has already been viewed. If it hasn't, the product is added to the list of viewed products
     and saved to UserDefaults.
     */
    func markProductAsViewed(_ product: Product) -> Bool {
        var viewedProducts = userDefaultsManager.getProductViewed()
        
        // Check if the product has already been viewed
        let isAlreadyViewed = viewedProducts.first { $0.id == product.id }
        
        if isAlreadyViewed != nil {
            return false // Product has already been viewed
        }
        
        // Insert the product at the start of the viewed list
        viewedProducts.insert(product, at: 0)
        userDefaultsManager.setProductViewed(viewedProducts)
        return true // Product marked as viewed for the first time
    }
    
    /**
     Adds a product to the cart with a specified quantity.
     
     - Parameter product: The product to add to the cart.
     - Parameter qtd: The quantity of the product to add.
     
     This method creates a new `CartModel` with the provided product and quantity, then adds it to the cart
     stored in UserDefaults.
     */
    func addProductToCart(_ product: Product, quantity: Int) {
        let newCartItem = ShoppingCart(quantity: quantity, product: product)
        var cartItems = userDefaultsManager.getCart()
        
        // Append the new product to the cart
        cartItems.append(newCartItem)
        userDefaultsManager.setCart(cartItems)
    }
    
    /**
     Toggles the saved status of a product. If the product is already saved, it will be removed from the saved list.
     If the product is not saved, it will be added to the saved list.
     
     - Parameter product: The product to save or unsave.
     - Returns: A boolean indicating whether the product is now saved (`true`) or unsaved (`false`).
     
     This method checks if the product is already in the saved list. If it is, the product is removed.
     Otherwise, the product is marked as saved and added to the list.
     */
    func toggleSavedProduct(_ product: Product) -> Bool {
        var savedProducts = userDefaultsManager.getSaved()
        
        // Check if the product is already saved
        if let index = savedProducts.firstIndex(where: { $0.id == product.id }) {
            savedProducts.remove(at: index) // Remove product from saved list
            userDefaultsManager.setSaved(savedProducts)
            return false // Product is now unsaved
        }
        
        // Mark the product as saved and add to the list
        var updatedProduct = product
        updatedProduct.isSaved = true
        savedProducts.append(updatedProduct)
        
        userDefaultsManager.setSaved(savedProducts)
        return true // Product is now saved
    }
}
