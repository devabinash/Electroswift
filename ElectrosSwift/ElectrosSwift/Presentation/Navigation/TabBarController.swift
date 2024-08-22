//
//  CustomTabBarController.swift
//  ElectronicsStoreSwift
//
//  Created by Abhinash Bhattarai on 19/08/24.
//

import UIKit

/// A custom `UITabBarController` that manages the main navigation for the app with a modern and visually appealing design.
class CustomTabBarController: UITabBarController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        styleTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: - Private Methods

    /**
     Initializes and sets up the view controllers for the tab bar.
     
     This method creates instances of the primary view controllers and assigns them to the tab bar, associating each with a specific tab.
     */
    private func setupViewControllers() {
        let homeVC = HomeViewController()
        let cartVC = CartViewController()
        let savedVC = SavedViewController()
        let profileVC = ProfileViewController()
        
        let homeNav = createNavController(for: homeVC, title: "Home", iconName: "house.fill")
        let cartNav = createNavController(for: cartVC, title: "Cart", iconName: "cart.fill")
        let savedNav = createNavController(for: savedVC, title: "Saved", iconName: "bookmark.fill")
        let profileNav = createNavController(for: profileVC, title: "Profile", iconName: "person.fill")
        
        self.setViewControllers([homeNav, cartNav, savedNav, profileNav], animated: false)
    }
    
    /**
     Applies styling to the tab bar to enhance the UI appearance.
     
     This method sets the tint color and background color of the tab bar to match the app's design language.
     */
    private func styleTabBar() {
        tabBar.tintColor = UIColor(named: "Primary")
        tabBar.unselectedItemTintColor = UIColor(named: "Secondary")
        tabBar.barTintColor = UIColor(named: "Background")
        tabBar.isTranslucent = false
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.3
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        tabBar.layer.shadowRadius = 8
    }

    /**
     Creates a navigation controller with a specific view controller, title, and icon.
     
     - Parameters:
       - rootViewController: The view controller to be embedded in the navigation controller.
       - title: The title of the tab bar item.
       - iconName: The name of the system image icon for the tab bar item.
     - Returns: A `UINavigationController` configured with the specified view controller, title, and icon.
     
     This method helps to create each tab's navigation controller with a consistent appearance and functionality.
     */
    private func createNavController(for rootViewController: UIViewController, title: String, iconName: String) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(systemName: iconName)
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navController
    }
}
