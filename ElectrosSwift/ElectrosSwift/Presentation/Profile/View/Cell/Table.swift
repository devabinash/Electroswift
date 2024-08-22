//
//  ConfigTableViewCell.swift
//  ElectronicsStoreSwift
//
//  Created by Abhinash Bhattarai on 28/08/24.
//

import UIKit

/// A custom table view cell used for displaying configuration options in the settings screen.
class ConfigTableViewCell: UITableViewCell {
    // MARK: - Constants
    static let reuseIdentifier: String = "ConfigTableViewCell"
    
    // MARK: - UI Components
    private let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let iconContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = UIColor(named: "Disabled")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.right.circle")
        imageView.tintColor = UIColor(named: "Disabled")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let footerSeparatorLine = SeparationLine()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    /**
     Configures the cell by setting up its UI components and constraints.
     
     This method is responsible for building the cell's hierarchy and setting up the layout constraints.
     */
    private func configureCell() {
        buildHierarchy()
        setupConstraints()
    }
    
    // MARK: - Methods
    /**
     Configures the cell with data from the provided `ConfigModel`.
     
     - Parameter item: The `ConfigModel` object containing the data to be displayed in the cell.
     
     This method sets the title and icon for the cell based on the information in the provided `ConfigModel`.
     */
    func configure(with item: ConfigModel) {
        titleLabel.text = item.text
        iconImageView.image = UIImage(systemName: item.imageName)
    }
    
    /**
     Adds subviews to the cell's content view and arranges them in the hierarchy.
     
     This method is responsible for adding all the necessary UI components to the cell's content view.
     */
    private func buildHierarchy() {
        contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(iconContainerView)
        iconContainerView.addSubview(iconImageView)
        mainStackView.addArrangedSubview(titleLabel)
        contentView.addSubview(footerSeparatorLine)
        contentView.addSubview(arrowImageView)
    }
    
    /**
     Sets up the layout constraints for the UI components.
     
     This method defines the layout constraints for the stack view, image views, and other UI components, ensuring they are properly positioned within the cell.
     */
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            iconContainerView.widthAnchor.constraint(equalToConstant: 25),
            
            iconImageView.widthAnchor.constraint(equalToConstant: 25),
            iconImageView.centerXAnchor.constraint(equalTo: iconContainerView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconContainerView.centerYAnchor),
            
            footerSeparatorLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            footerSeparatorLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            footerSeparatorLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            arrowImageView.widthAnchor.constraint(equalToConstant: 25),
            arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
}
