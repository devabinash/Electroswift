import UIKit
import RxSwift

class HomeViewController: UIViewController {
    // MARK: - Constants
    private let disposeBag = DisposeBag()

    // MARK: - Variables
    private var viewModel: HomeViewModel = HomeViewModel()
    private var sectionData: [Category] = []

    // MARK: - UI Components
    private let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 32
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let homeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    // MARK: - Setup
    /**
     Sets up the view controller by initializing the view model, subscribing to data, and configuring the UI.
     
     This method initializes the view model, sets up the RxSwift subscriptions to handle data updates,
     and configures the UI components of the home screen.
     */
    private func setupViewController() {
        view.backgroundColor = UIColor(named: "Background")
        
        viewModel.productData.subscribe(onNext: { [weak self] data in
            self?.sectionData = data
            self?.homeCollectionView.reloadData()
        }).disposed(by: disposeBag)
        
        setupHierarchy()
        setupConstraints()
        setupCollectionView()
    }
    
    /**
     Configures the collection view by setting its data source, delegate, and registering cell classes.
     
     This method sets up the collection view to properly display the sections and products, and handles user interactions.
     */
    private func setupCollectionView() {
        homeCollectionView.dataSource = self
        homeCollectionView.delegate = self
        
        homeCollectionView.register(HeaderCollectionViewCell.self, forCellWithReuseIdentifier: HeaderCollectionViewCell.reuseIdentifier)
        homeCollectionView.register(HotSalesCollectionViewCell.self, forCellWithReuseIdentifier: HotSalesCollectionViewCell.reuseIdentifier)
        homeCollectionView.register(RecentlyViewedCollectionViewCell.self, forCellWithReuseIdentifier: RecentlyViewedCollectionViewCell.reuseIdentifier)
        homeCollectionView.register(DiscoverCollectionViewCell.self, forCellWithReuseIdentifier: DiscoverCollectionViewCell.reuseIdentifier)
        homeCollectionView.register(DiscoverItemCollectionViewCell.self, forCellWithReuseIdentifier: DiscoverItemCollectionViewCell.reuseIdentifier)
    }

    // MARK: - UI Setup
    /**
     Adds subviews to the main view and arranges them in the hierarchy.
     
     This method builds the view hierarchy by adding the necessary UI components to the main view.
     */
    private func setupHierarchy() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(homeCollectionView)
    }
    
    /**
     Sets up the constraints for the UI components.
     
     This method defines the layout constraints for the stack view and collection view, ensuring they are properly positioned within the view.
     */
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.section == 4 else { return }
        
        let detailsVC = DetailsProductViewController()
        detailsVC.delegate = self
        detailsVC.configureScreen(with: sectionData[2].items[indexPath.row])
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0, 1, 3: // Header, Hot Sales, and Discover Header
            return 1
            
        case 2: // Recently Viewed
            return sectionData[1].items.isEmpty ? 0 : 1
            
        case 4: // Discover Items
            return sectionData.isEmpty ? 0 : sectionData[2].items.count
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {        
        switch indexPath.section {
        case 0: // Header
            return collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCollectionViewCell.reuseIdentifier, for: indexPath)
            
        case 1: // Hot Sales
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotSalesCollectionViewCell.reuseIdentifier, for: indexPath) as! HotSalesCollectionViewCell
            cell.configure(with: sectionData[0].items)
            cell.delegate = self
            return cell
            
        case 2: // Recently Viewed
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentlyViewedCollectionViewCell.reuseIdentifier, for: indexPath) as! RecentlyViewedCollectionViewCell
            cell.configure(with: sectionData[1].items)
            cell.delegate = self
            return cell
            
        case 3: // Discover Header
            return collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverCollectionViewCell.reuseIdentifier, for: indexPath)
            
        case 4: // Discover Items
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverItemCollectionViewCell.reuseIdentifier, for: indexPath) as! DiscoverItemCollectionViewCell
            cell.configure(with: sectionData[2].items[indexPath.row])
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        
        switch indexPath.section {
        case 0: // Header
            return CGSize(width: width, height: 166)
            
        case 1: // Hot Sales
            return CGSize(width: width, height: 260)
            
        case 2: // Recently Viewed
            return CGSize(width: width, height: 260)
            
        case 3: // Discover Header
            return CGSize(width: width, height: 15)
            
        case 4: // Discover Items
            return CGSize(width: (width / 2) - 10, height: 200)
            
        default:
            return CGSize.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
}

// MARK: - HotSalesCollectionViewCellDelegate
extension HomeViewController: HotSalesCollectionViewCellDelegate {
    func navigateToDetails(_ product: Product) {
        let detailsVC = DetailsProductViewController()
        detailsVC.delegate = self
        detailsVC.configureScreen(with: product)
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}

// MARK: - RecentlyViewedCollectionViewCellDelegate
extension HomeViewController: RecentlyViewedCollectionViewCellDelegate {
    func navigateFromRecentlyViewedToDetails(_ product: Product) {
        let detailsVC = DetailsProductViewController()
        detailsVC.delegate = self
        detailsVC.configureScreen(with: product)
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}

// MARK: - DetailsProductViewControllerDelegate
extension HomeViewController: DetailsProductViewControllerDelegate {
    func productViewed() {
        viewModel.updateProductViewed()
    }
    
    func productIsSaved(_ id: String, isSaved: Bool) {
        viewModel.updateProductSaved(id, isSaved: isSaved)
    }
}
