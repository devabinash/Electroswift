import Foundation
import RxSwift
import RxRelay

class CartViewModel {
    // MARK: - Constants
    let userDefaultsManager = UserDefaultsManagement()
    
    // MARK: - Variables
    var cartItems = BehaviorRelay<[ShoppingCart]>(value: [])
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    public init() {
        loadCartData()
    }
    
    func loadCartData() {
        let cartItemsFromUserDefaults = userDefaultsManager.getCart()
        cartItems.accept(cartItemsFromUserDefaults)
    }
    
    func getTotalValue() -> Float {
        let totalArray = cartItems.value.map { Float($0.quantity) * $0.product.cost }
        return totalArray.reduce(0, +)
    }
    
    func updateCartItemQuantity(_ cartItem: ShoppingCart) {
        var carts = cartItems.value
        
        if let index = carts.firstIndex(where: { $0.product.identifier == cartItem.product.identifier }) {
            carts[index].quantity = cartItem.quantity

            userDefaultsManager.setCart(carts)
            cartItems.accept(carts)
        }
    }
}
