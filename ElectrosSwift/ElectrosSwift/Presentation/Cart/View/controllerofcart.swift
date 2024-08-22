import UIKit
import RxSwift

class CartViewController: UIViewController {
    // MARK: - Constants
    fileprivate let disposeBag = DisposeBag()
    private let headerReuseIdentifier = "CartHeaderView"
    
    // MARK: - Variables
    fileprivate var viewModel: CartViewModel = {
        return CartViewModel()
    }()
    
    fileprivate var cartItems: [ShoppingCart] = []
    
    // MARK: - Components
    fileprivate let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let headerView: ScreenHeader = {
        let header = ScreenHeader()
        header.title = "My Cart"
        return header
    }()
    
    fileprivate let emptyView: EmptyView = {
        let view = EmptyView()
        view.title = "Your cart is empty"
        view.isHidden = true
        return view
    }()
    
    fileprivate let cartCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.bounces = false
        return collectionView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.getData()
    }
    
    // MARK: - Setup
    fileprivate func setupViewController() {
        view.backgroundColor = UIColor(named: "Background")
        
        self.viewModel.cartItems
            .subscribe(onNext: { items in
                self.cartItems = items
                self.cartCollectionView.reloadData()
                self.updateViewVisibility()
            })
            .disposed(by: disposeBag)
        
        updateViewVisibility()
        setupHierarchy()
        setupConstraints()
        setupCollectionView()
    }
    
    fileprivate func setupCollectionView() {
        cartCollectionView.dataSource = self
        cartCollectionView.delegate = self
        
        cartCollectionView.register(CartItemCollectionViewCell.self, forCellWithReuseIdentifier: CartItemCollectionViewCell.reuseIdentifier)
        cartCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier)
        cartCollectionView.register(CartFooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CartFooterCollectionReusableView.reuseIdentifier)
    }

    // MARK: - Methods
    fileprivate func updateViewVisibility() {
        if self.cartItems.isEmpty {
            self.cartCollectionView.isHidden = true
            self.emptyView.isHidden = false
        } else {
            self.cartCollectionView.isHidden = false
            self.emptyView.isHidden = true
        }
    }
    
    fileprivate func setupHierarchy() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(headerView)
        mainStackView.addArrangedSubview(cartCollectionView)
        mainStackView.addArrangedSubview(emptyView)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

// MARK: - UICollectionViewDelegate
extension CartViewController: UICollectionViewDelegate {}

// MARK: - UICollectionViewDataSource
extension CartViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cartItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CartItemCollectionViewCell.reuseIdentifier, for: indexPath) as! CartItemCollectionViewCell
        cell.configure(with: self.cartItems[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    // Header & Footer
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier, for: indexPath)
            return header
            
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CartFooterCollectionReusableView.reuseIdentifier, for: indexPath) as! CartFooterCollectionReusableView
            footer.configure(subtotal: self.viewModel.getTotalValue())
            return footer
        default:
            assert(false, "Unexpected element kind")
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CartViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: 97)
    }
    
    // Header
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: 16)
    }
    
    // Footer
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let width = collectionView.frame.width
        return self.cartItems.isEmpty ? CGSize(width: width, height: 0) : CGSize(width: width, height: 350)
    }
}

// MARK: - CartItemCollectionViewCellDelegate
extension CartViewController: CartItemCollectionViewCellDelegate {
    func updateQuantity(_ cartItem: ShoppingCart) {
        self.viewModel.updateQuantityCartItem(cartItem)
    }
}
