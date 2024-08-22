import UIKit

protocol CartItemCollectionViewCellDelegate {
    func updateQuantity(_ cartItem: ShoppingCart)
}

class CartItemCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants
    static let reuseIdentifier: String = "CartItemCollectionViewCell"
    
    // MARK: - Variables
    var cartItem: ShoppingCart?
    var delegate: CartItemCollectionViewCellDelegate?
    
    // MARK: - Components
    private let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let imageContainerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        view.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let contentContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let textStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let itemNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let itemDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 8, weight: .regular)
        label.textColor = UIColor(named: "Disabled")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let itemPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let footerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let quantityButtons: ButtonsQtd = {
        let view = ButtonsQtd()
        return view
    }()
    
    private let bottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.96, green: 0.97, blue: 0.97, alpha: 1.00)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func configureCell() {
        self.quantityButtons.delegate = self
        
        setupHierarchy()
        setupConstraints()
    }
    
    // MARK: - Methods
    func configure(with item: ShoppingCart) {
        self.itemNameLabel.text = item.product.itemName
        self.itemPriceLabel.text = "$\(item.product.cost)"
        self.itemDescriptionLabel.text = item.product.details
        self.itemImageView.image = UIImage(named: item.product.imageNames[0])
        
        self.quantityButtons.setQtd(item.quantity)
        self.cartItem = item
    }
    
    private func setupHierarchy() {
        self.addSubview(mainStackView)
        mainStackView.addArrangedSubview(imageContainerView)
        imageContainerView.addSubview(itemImageView)
        mainStackView.addArrangedSubview(contentContainerView)
        
        contentContainerView.addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(textStackView)
        textStackView.addArrangedSubview(itemNameLabel)
        textStackView.addArrangedSubview(itemDescriptionLabel)
        
        contentStackView.addArrangedSubview(footerStackView)
        footerStackView.addArrangedSubview(itemPriceLabel)
        footerStackView.addArrangedSubview(quantityButtons)
        
        self.addSubview(bottomBorderView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            
            imageContainerView.widthAnchor.constraint(equalToConstant: 80),
            
            itemImageView.topAnchor.constraint(equalTo: imageContainerView.topAnchor, constant: 16),
            itemImageView.leadingAnchor.constraint(equalTo: imageContainerView.leadingAnchor, constant: 16),
            itemImageView.trailingAnchor.constraint(equalTo: imageContainerView.trailingAnchor, constant: -16),
            itemImageView.bottomAnchor.constraint(equalTo: imageContainerView.bottomAnchor, constant: -16),
            
            contentStackView.topAnchor.constraint(equalTo: contentContainerView.topAnchor, constant: 8),
            contentStackView.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: contentContainerView.bottomAnchor, constant: -8),
            
            bottomBorderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomBorderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomBorderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomBorderView.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
}

// MARK: - ButtonsQtdDelegate
extension CartItemCollectionViewCell: ButtonsQtdDelegate {
    func updateQtd(_ qtd: Int) {
        guard var cartItem = self.cartItem else { return }
        
        cartItem.quantity = qtd
        
        self.delegate?.updateQuantity(cartItem)
    }
}
