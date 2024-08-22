//
//  ProfileViewController.swift
//  ElectronicsStoreSwift
//
//  Created by Abhinash Bhattarai on 28/08/24.
//

import UIKit

/// A view controller that manages and displays the user's profile and settings options.
class ProfileViewController: UIViewController {
    // MARK: - Constants
    private let profileOptions: [ConfigModel] = [
        ConfigModel(text: "Edit Personal Info", imageName: "list.bullet.rectangle.fill"),
        ConfigModel(text: "Orders", imageName: "cart.fill"),
        ConfigModel(text: "Addresses", imageName: "mappin.circle.fill"),
        ConfigModel(text: "Payments", imageName: "creditcard.fill"),
    ]
    
    // MARK: - UI Components
    private let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 32
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let headerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let screenHeader: ScreenHeader = {
        let header = ScreenHeader()
        header.title = "Profile"
        return header
    }()
    
    private let profileImageContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let profileImageShadowView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        view.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.00)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.image = UIImage(named: "avatar")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Joãozinho"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let profileOptionsTableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.bounces = false
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    // MARK: - Setup
    /**
     Configures the view controller's main setup, including adding subviews, setting constraints, and configuring the table view.
     
     This method sets the background color, builds the view hierarchy, and applies constraints. It also configures the table view's data source and delegate.
     */
    private func configureViewController() {
        view.backgroundColor = UIColor(named: "Background")
        buildHierarchy()
        applyConstraints()
        configureTableView()
    }
    
    /**
     Configures the profile options table view by setting its data source, delegate, and registering the custom cell class.
     
     This method ensures that the table view displays the correct data and handles user interactions.
     */
    private func configureTableView() {
        profileOptionsTableView.dataSource = self
        profileOptionsTableView.delegate = self
        profileOptionsTableView.register(ConfigTableViewCell.self, forCellReuseIdentifier: ConfigTableViewCell.reuseIdentifier)
    }

    // MARK: - UI Setup
    /**
     Adds subviews to the view and arranges them in the view hierarchy.
     
     This method is responsible for building the view hierarchy by adding UI components to their appropriate parent views.
     */
    private func buildHierarchy() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(headerStackView)
        
        headerStackView.addArrangedSubview(screenHeader)
        headerStackView.addArrangedSubview(profileImageContainerView)
        profileImageContainerView.addSubview(profileImageShadowView)
        profileImageContainerView.addSubview(profileImageView)
        headerStackView.addArrangedSubview(nameLabel)
        
        mainStackView.addArrangedSubview(profileOptionsTableView)
    }
    
    /**
     Applies layout constraints to the UI components.
     
     This method defines the layout constraints for the stack views, profile image, and table view, ensuring that they are properly positioned within the view.
     */
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            profileImageContainerView.heightAnchor.constraint(equalToConstant: 100),
            
            profileImageShadowView.widthAnchor.constraint(equalToConstant: 100),
            profileImageShadowView.heightAnchor.constraint(equalToConstant: 100),
            profileImageShadowView.centerXAnchor.constraint(equalTo: profileImageContainerView.centerXAnchor),
            profileImageShadowView.centerYAnchor.constraint(equalTo: profileImageContainerView.centerYAnchor),
            
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80),
            profileImageView.centerXAnchor.constraint(equalTo: profileImageContainerView.centerXAnchor),
            profileImageView.centerYAnchor.constraint(equalTo: profileImageContainerView.centerYAnchor),
        ])
    }
}

// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
}

// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConfigTableViewCell.reuseIdentifier, for: indexPath) as! ConfigTableViewCell
        cell.configure(with: profileOptions[indexPath.row])
        return cell
    }
}
