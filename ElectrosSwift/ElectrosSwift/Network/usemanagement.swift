import Foundation

class UserDefaultsManagement {
    
    // MARK: - Item
    func getItemsViewed() -> [Item] {
        let userDefaults = UserDefaults.standard
        do {
            let arrayUserDefault = try userDefaults.getObject(forKey: "itemsViewed", castTo: [Item].self)
            return arrayUserDefault
        } catch {
            return []
        }
    }
    
    func setItemsViewed(_ items: [Item]) {
        let userDefaults = UserDefaults.standard
        do {
            try userDefaults.setObject(items, forKey: "itemsViewed")
        } catch {
        }
    }
    
    // MARK: - Cart
    func getCart() -> [ShoppingCart] {
        let userDefaults = UserDefaults.standard
        do {
            let arrayUserDefault = try userDefaults.getObject(forKey: "cart", castTo: [ShoppingCart].self)
            return arrayUserDefault
        } catch {
            return []
        }
    }
    
    func setCart(_ carts: [ShoppingCart]) {
        let userDefaults = UserDefaults.standard
        do {
            try userDefaults.setObject(carts, forKey: "cart")
        } catch {
        }
    }
    
    // MARK: - Favorites
    func getFavorites() -> [Item] {
        let userDefaults = UserDefaults.standard
        do {
            let arrayUserDefault = try userDefaults.getObject(forKey: "favorites", castTo: [Item].self)
            return arrayUserDefault
        } catch {
            return []
        }
    }
    
    func setFavorites(_ items: [Item]) {
        let userDefaults = UserDefaults.standard
        do {
            try userDefaults.setObject(items, forKey: "favorites")
        } catch {
        }
    }
    
}
