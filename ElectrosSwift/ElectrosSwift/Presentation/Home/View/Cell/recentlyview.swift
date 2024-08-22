import UIKit
import RxSwift
import RxRelay

protocol RecentlyViewedCollectionViewCellDelegate {
    func navigationFromRecentlyToDetails(_ product: Product)
}

class RecentlyViewedCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants
    static let resuseIdentifier: String = "RecentlyViewedCollectionViewCell"
    let disposeBag = DisposeBag()
    
    // MARK: - Variables
    fileprivate var cellData = BehaviorRelay<[Product]>(value: [])
    var delegate: RecentlyViewedCollectionViewCellDelegate?
    
    // MARK: - Components
    fileprivate let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let stackText: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let labelSectionTitle: UILabel = {
        let label = UILabel()
        label.text = "Recently Viewed"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let labelSeeAll: UILabel = {
        let label = UILabel()
        label.text = "See all"
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(named: "Disabled")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let collectionViewHotSales: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.bounces = false
        return collectionView
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
        self.cellData.subscribe(onNext: { data in
            self.collectionViewHotSales.reloadData()
        }).disposed(by: disposeBag)
        
        buildHierarchy()
        buildConstraints()
        
        setupCollection()
    }
    
    fileprivate func setupCollection() {
        collectionViewHotSales.dataSource = self
        collectionViewHotSales.delegate = self
        
        collectionViewHotSales.register(RecentlyViewedCellCollectionViewCell.self, forCellWithReuseIdentifier: RecentlyViewedCellCollectionViewCell.resuseIdentifier)
    }
    
    // MARK: - Methods
    func settingCell(_ items: [Product]) {
        self.cellData.accept(items)
    }
    
    fileprivate func buildHierarchy() {
        self.addSubview(stackBase)
        stackBase.addArrangedSubview(stackText)
        stackText.addArrangedSubview(labelSectionTitle)
        stackText.addArrangedSubview(labelSeeAll)
        
        stackBase.addArrangedSubview(collectionViewHotSales)
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: self.topAnchor),
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}

// MARK: - extension UICollectionViewDelegate
extension RecentlyViewedCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.navigationFromRecentlyToDetails(cellData.value[indexPath.row])
    }
}

// MARK: - extension CollectionViewDataSource
extension RecentlyViewedCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cellData.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentlyViewedCellCollectionViewCell.resuseIdentifier, for: indexPath) as! RecentlyViewedCellCollectionViewCell
        cell.settingCell(self.cellData.value[indexPath.row])
        return cell
    }
}

// MARK: - extension CollectionViewDelegateFlowLayout
extension RecentlyViewedCollectionViewCell: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = collectionView.frame.width
        let height = collectionView.frame.height
        return CGSize(width: 160, height: height)
    }
}


