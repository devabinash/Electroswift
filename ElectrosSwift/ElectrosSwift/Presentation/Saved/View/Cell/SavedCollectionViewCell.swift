//
//  SavedCollectionViewCell.swift
//  ElectronicsStoreSwift
//
//  Created by Pinto Junior, William James on 22/07/22.
//

import UIKit

class SavedCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants
    static let resuseIdentifier: String = "SavedCollectionViewCell"
    
    // MARK: - Components
    fileprivate let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let viewImageContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.backgroundColor = UIColor(red: 0.88, green: 0.94, blue: 0.98, alpha: 1.00)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let imageViewItem: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate let viewStackTextContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let stackText: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let viewStackTextAux: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let labelName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let labelValue: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let stackButtons: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let buttonSaved: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.backgroundColor = .white
        button.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        button.tintColor = UIColor(named: "Disabled")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate let buttonAdd: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 4
        button.backgroundColor = UIColor(named: "Primary")
        button.setTitle("Add to cart", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupVC()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    fileprivate func setupVC() {
        self.backgroundColor = .white
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Methods
    func settingCell(_ item: Product) {
        self.labelName.text = item.name
        self.labelValue.text = "$\(item.price)"
        self.imageViewItem.image = UIImage(named: item.imagesName[0])
    }
    
    fileprivate func buildHierarchy() {
        self.addSubview(stackBase)
        stackBase.addArrangedSubview(viewImageContainer)
        viewImageContainer.addSubview(imageViewItem)
        stackBase.addArrangedSubview(viewStackTextContainer)
        
        viewStackTextContainer.addSubview(stackText)
        stackText.addArrangedSubview(labelName)
        stackText.addArrangedSubview(labelValue)
        stackText.addArrangedSubview(viewStackTextAux)
        stackText.addArrangedSubview(buttonAdd)
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: self.topAnchor),
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            viewImageContainer.widthAnchor.constraint(equalToConstant: 150),
            
            imageViewItem.topAnchor.constraint(equalTo: viewImageContainer.topAnchor, constant: 16),
            imageViewItem.leadingAnchor.constraint(equalTo: viewImageContainer.leadingAnchor, constant: 16),
            imageViewItem.trailingAnchor.constraint(equalTo: viewImageContainer.trailingAnchor, constant: -16),
            imageViewItem.bottomAnchor.constraint(equalTo: viewImageContainer.bottomAnchor, constant: -16),
            
            stackText.topAnchor.constraint(equalTo: viewStackTextContainer.topAnchor, constant: 16),
            stackText.leadingAnchor.constraint(equalTo: viewStackTextContainer.leadingAnchor),
            stackText.trailingAnchor.constraint(equalTo: viewStackTextContainer.trailingAnchor),
            stackText.bottomAnchor.constraint(equalTo: viewStackTextContainer.bottomAnchor, constant: -16),
            
            buttonAdd.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
