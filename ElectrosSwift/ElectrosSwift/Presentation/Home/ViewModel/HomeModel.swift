//
//  HomeViewModel.swift
//  ElectronicsStoreSwift
//
//  Created by Abhinash Bhattarai on 22/08/2024.
//

import Foundation
import RxSwift
import RxRelay

/// ViewModel responsible for managing the home screen data, including recently viewed and saved products.
class HomeViewModel {
    // MARK: - Variables
    private let userDefaultsManager = UserDefaultsManagement()
    var sectionsRelay = BehaviorRelay<[Category]>(value: [])
    
    // MARK: - Init
    public init() {
        initializeData()
    }
    
    // MARK: - Methods
    
    /**
     Updates the `sectionsRelay` with the latest viewed products.
     
     This method retrieves the list of viewed products from `UserDefaults`, updates the corresponding section in the data, and then pushes the updated data to the `sectionsRelay`.
     */
    func updateProductViewed() {
        var sections = sectionsRelay.value
        let viewedProducts = userDefaultsManager.getItemsViewed()
        
        sections[1].items = viewedProducts
        
        sectionsRelay.accept(sections)
    }
    
    /**
     Updates the saved status of a specific product across all sections and saves the updated list of viewed products.
     
     - Parameters:
       - id: The unique identifier of the product.
       - isSaved: A boolean indicating whether the product is saved or not.
     
     This method updates the saved status of a product in all relevant sections and persists the updated list of recently viewed products.
     */
    func updateProductSaved(_ id: String, isSaved: Bool) {
        var sections = sectionsRelay.value
        
        sections[0].items = updateProductSavedStatus(products: sections[0].items, savedIDs: [id], value: isSaved)
        sections[1].items = updateProductSavedStatus(products: sections[1].items, savedIDs: [id], value: isSaved)
        sections[2].items = updateProductSavedStatus(products: sections[2].items, savedIDs: [id], value: isSaved)

        userDefaultsManager.setItemsViewed(sections[1].items)
        
        sectionsRelay.accept(sections)
    }
    
    /**
     Initializes the home screen data by applying viewed and saved products from `UserDefaults`.
     
     This method fetches the initial data and applies any saved and viewed products from `UserDefaults` to ensure the home screen displays the most accurate information.
     */
    private func initializeData() {
        var sections = fetchData()
        
        sections = applyViewedProducts(sections)
        sections = applySavedProducts(sections)
        
        sectionsRelay.accept(sections)
    }
    
    /**
     Applies the list of viewed products to the appropriate section.
     
     - Parameter sections: The original list of sections.
     - Returns: The updated list of sections with viewed products applied.
     
     This method retrieves the viewed products from `UserDefaults` and appends them to the corresponding section if they exist.
     */
    private func applyViewedProducts(_ sections: [Category]) -> [Category] {
        let viewedProducts = userDefaultsManager.getItemsViewed()
        var updatedSections = sections
        
        if !viewedProducts.isEmpty {
            updatedSections[1].items += viewedProducts
        }
        
        return updatedSections
    }
    
    /**
     Applies the saved status to the appropriate products across all sections.
     
     - Parameter sections: The original list of sections.
     - Returns: The updated list of sections with saved status applied to products.
     
     This method updates the saved status of products by checking against the list of saved items in `UserDefaults`.
     */
    private func applySavedProducts(_ sections: [Category]) -> [Category] {
        let savedProducts = userDefaultsManager.getFavorites()
        var updatedSections = sections
        
        if savedProducts.isEmpty {
            return updatedSections
        }
        
        let savedIDs = savedProducts.map { $0.identifier }
        
        updatedSections[0].items = updateProductSavedStatus(products: updatedSections[0].items, savedIDs: savedIDs, value: true)
        updatedSections[1].items = updateProductSavedStatus(products: updatedSections[1].items, savedIDs: savedIDs, value: true)
        updatedSections[2].items = updateProductSavedStatus(products: updatedSections[2].items, savedIDs: savedIDs, value: true)
        
        return updatedSections
    }
    
    /**
     Updates the saved status of products based on a list of saved product IDs.
     
     - Parameters:
       - products: The list of products to update.
       - savedIDs: The list of product IDs that should be marked as saved.
       - value: The boolean value indicating the saved status to apply.
     - Returns: The updated list of products with the correct saved status.
     
     This method iterates through a list of products and updates the saved status of each product that matches an ID in the `savedIDs` list.
     */
    private func updateProductSavedStatus(products: [Product], savedIDs: [String], value: Bool) -> [Product] {
        var updatedProducts = products
        
        for id in savedIDs {
            if let index = updatedProducts.firstIndex(where: { $0.identifier == id }) {
                updatedProducts[index].isFavorite = value
            }
        }
        
        return updatedProducts
    }
    
    /**
     Fetches the initial data for the home screen sections.
     
     - Returns: An array of `Category` objects representing the sections for the home screen.
     
     This method fetches the initial data needed for the home screen from an external source or service.
     */
    private func fetchData() -> [Category] {
        return GetPublication().fetchCategories()
    }
}
