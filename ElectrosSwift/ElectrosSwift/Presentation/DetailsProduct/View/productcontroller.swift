import UIKit
import RxSwift

protocol DetailsProductViewControllerDelegate: AnyObject {
    func productIsSaved(_ id: String, isSaved: Bool)
    func productViewed()
}

class DetailsProductViewController: UIViewController {
    // MARK: - Variables
    weak var delegate: DetailsProductViewControllerDelegate?
    var viewModel: DetailsProductViewModel = DetailsProductViewModel()
    private var selectedProduct: Product?
    
    // MARK: - Components
    private let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 32
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let auxiliaryView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "ImageBackground")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let productCarousel: CarouselDetailsProduct = {
        let view = CarouselDetailsProduct()
        return view
    }()
    
    private let contentContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let nameAndSavedStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 12.5
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.96, green: 0.97, blue: 0.97, alpha: 1.00).cgColor
        button.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        button.tintColor = UIColor(named: "Disabled")
        button.addTarget(self, action: #selector(handleSavedButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let itemNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let itemDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 11, weight: .bold)
        label.textColor = UIColor(named: "Disabled")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let valueAndColorStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let itemPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let chooseColorView: ChooseColor = {
        let view = ChooseColor()
        return view
    }()
    
    private let footerSeparatorLine = SeparationLine()
    
    private let footerContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let footerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 32
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let quantityButtons: ButtonsQtd = {
        let view = ButtonsQtd()
        return view
    }()
    
    private let addToCartButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(named: "Primary")
        button.tintColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.setTitle("Add to Cart", for: .normal)
        button.addTarget(self, action: #selector(handleAddToCartButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Actions
    @objc private func handleAddToCartButtonTapped(sender: UIButton) {
        guard let selectedProduct = selectedProduct else { return }
        let quantity = self.quantityButtons.qtdSelected
        
        viewModel.addProductToCart(selectedProduct, quantity: quantity)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleSavedButtonTapped(sender: UIButton) {
        guard let selectedProduct = selectedProduct else { return }
        
        let isSaved = self.viewModel.toggleSavedProduct(selectedProduct)
        self.delegate?.productIsSaved(selectedProduct.id, isSaved: isSaved)
        
        self.saveButton.tintColor = selectedProduct.isSaved ? UIColor(named: "Primary") : UIColor(named: "Disabled")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    // MARK: - Setup
    private func configureViewController() {
        self.title = "Product Details"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)]
        
        view.backgroundColor = UIColor(named: "Background")
        setupHierarchy()
        setupConstraints()
    }

    // MARK: - Methods
    func configureScreen(with item: Product) {
        self.itemNameLabel.text = item.name
        self.itemPriceLabel.text = "$ \(item.price)"
        self.itemDescriptionLabel.text = item.description
        
        let colors = item.colors.map { self.hexStringToUIColor(hex: $0) }
        self.chooseColorView.setButtonColors(colors)
        self.productCarousel.configure(with: item.imagesName)
        
        if self.viewModel.setProductViewed(item) {
            self.delegate?.productViewed()
        }
        
        self.selectedProduct = item
        
        if item.isSaved {
            self.saveButton.tintColor = UIColor(named: "Primary")
        }
    }
    
    private func setupHierarchy() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(imageContainerView)
        imageContainerView.addSubview(productCarousel)
        
        mainStackView.addArrangedSubview(contentContainerView)
        contentContainerView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(nameAndSavedStackView)
        nameAndSavedStackView.addArrangedSubview(itemNameLabel)
        nameAndSavedStackView.addArrangedSubview(saveButton)
        contentStackView.addArrangedSubview(itemDescriptionLabel)
        contentStackView.addArrangedSubview(valueAndColorStackView)
        valueAndColorStackView.addArrangedSubview(itemPriceLabel)
        valueAndColorStackView.addArrangedSubview(chooseColorView)
        
        mainStackView.addArrangedSubview(footerSeparatorLine)
        
        mainStackView.addArrangedSubview(footerContainerView)
        footerContainerView.addSubview(footerStackView)
        footerStackView.addArrangedSubview(quantityButtons)
        footerStackView.addArrangedSubview(addToCartButton)
        
        mainStackView.addArrangedSubview(auxiliaryView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            imageContainerView.heightAnchor.constraint(equalToConstant: 300),
            
            productCarousel.topAnchor.constraint(equalTo: imageContainerView.topAnchor),
            productCarousel.leadingAnchor.constraint(equalTo: imageContainerView.leadingAnchor),
            productCarousel.trailingAnchor.constraint(equalTo: imageContainerView.trailingAnchor),
            productCarousel.bottomAnchor.constraint(equalTo: imageContainerView.bottomAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: contentContainerView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor, constant: -16),
            contentStackView.bottomAnchor.constraint(equalTo: contentContainerView.bottomAnchor),
            
            saveButton.widthAnchor.constraint(equalToConstant: 25),
            saveButton.heightAnchor.constraint(equalToConstant: 25),
            
            footerStackView.topAnchor.constraint(equalTo: footerContainerView.topAnchor),
            footerStackView.leadingAnchor.constraint(equalTo: footerContainerView.leadingAnchor, constant: 16),
            footerStackView.trailingAnchor.constraint(equalTo: footerContainerView.trailingAnchor, constant: -16),
            footerStackView.bottomAnchor.constraint(equalTo: footerContainerView.bottomAnchor),
            
            addToCartButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}

// MARK: - Utility Methods
extension DetailsProductViewController {
    private func hexStringToUIColor(hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if cString.count != 6 {
            return UIColor.gray
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: 1.0
        )
    }
}
