//
//  NavigationController.swift
//  ElectronicsStoreSwift
//
//  Created by Abhinash Bhattarai on 22/08/2024.
//

import UIKit

/// A custom `UINavigationController` subclass that handles navigation bar customization.
public class CustomNavigationController: UINavigationController {
    
    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    // MARK: - Private Methods
    /**
     Configures the appearance and settings of the navigation bar.
     
     This method customizes the navigation bar's appearance, making it translucent with a clear background and setting the tint color for the bar items.
     */
    private func configureNavigationBar() {
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = .clear
        navigationBar.tintColor = .black
    }
}
