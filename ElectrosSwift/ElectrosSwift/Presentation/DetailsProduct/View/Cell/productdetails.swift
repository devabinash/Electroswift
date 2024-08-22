import UIKit
import RxSwift
import RxCocoa

class CarouselDetailsProduct: UIView {
    // MARK: - Variables
    private var imageNames: [String] = []
    private let disposeBag = DisposeBag()
    
    // MARK: - Components
    private let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let carouselCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let carouselPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = UIColor(named: "Primary")
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func configureView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.carouselPageControl.numberOfPages = self.imageNames.count
        
        setupHierarchy()
        setupConstraints()
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        carouselCollectionView.dataSource = self
        carouselCollectionView.delegate = self
        
        carouselCollectionView.register(CarouselDetailsProductCollectionViewCell.self, forCellWithReuseIdentifier: CarouselDetailsProductCollectionViewCell.reuseIdentifier)
    }
    
    // MARK: - Methods
    func configure(with items: [String]) {
        self.imageNames = items
        self.carouselPageControl.numberOfPages = imageNames.count
        self.carouselCollectionView.reloadData()
    }
    
    private func setupHierarchy() {
        self.addSubview(carouselCollectionView)
        self.addSubview(carouselPageControl)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            carouselCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            carouselCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            carouselCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            carouselCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            carouselPageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            carouselPageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}

extension CarouselDetailsProduct: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPos = scrollView.contentOffset.x / self.carouselCollectionView.frame.size.width
        if !scrollPos.isNaN {
            carouselPageControl.currentPage = Int(scrollPos)
        }
    }
}

extension CarouselDetailsProduct: UICollectionViewDataSource {    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselDetailsProductCollectionViewCell.reuseIdentifier, for: indexPath) as! CarouselDetailsProductCollectionViewCell
        cell.configure(with: self.imageNames[indexPath.row])
        return cell
    }
}


extension CarouselDetailsProduct: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
}
