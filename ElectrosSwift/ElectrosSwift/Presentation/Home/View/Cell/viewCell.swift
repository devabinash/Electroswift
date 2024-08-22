import UIKit

class DiscoverCellCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants
    static let resuseIdentifier: String = "DiscoverCellCollectionViewCell"
    
    // MARK: - Components
    fileprivate let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let viewImageContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
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
    
    fileprivate let viewCicle: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.backgroundColor = UIColor(named: "Text")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let stackText: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let labelItemName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let labelItemValue: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Methods
    func settingCell(_ cellData: Product) {
        self.labelItemName.text = cellData.name
        self.labelItemValue.text = "$\(cellData.price)"
        self.imageViewItem.image = UIImage(named: cellData.imagesName[0])
    }
    
    fileprivate func buildHierarchy() {
        self.addSubview(stackBase)
        stackBase.addArrangedSubview(viewImageContainer)
        viewImageContainer.addSubview(imageViewItem)
        
        stackBase.addArrangedSubview(stackText)
        stackText.addArrangedSubview(labelItemName)
        stackText.addArrangedSubview(labelItemValue)
        
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: self.topAnchor),
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            viewImageContainer.heightAnchor.constraint(equalToConstant: 150),
            
            imageViewItem.topAnchor.constraint(equalTo: viewImageContainer.topAnchor, constant: 16),
            imageViewItem.leadingAnchor.constraint(equalTo: viewImageContainer.leadingAnchor, constant: 16),
            imageViewItem.trailingAnchor.constraint(equalTo: viewImageContainer.trailingAnchor, constant: -16),
            imageViewItem.bottomAnchor.constraint(equalTo: viewImageContainer.bottomAnchor, constant: -16),
            
//            viewCicle.widthAnchor.constraint(equalToConstant: 30),
//            viewCicle.heightAnchor.constraint(equalToConstant: 30),
//            viewCicle.trailingAnchor.constraint(equalTo: viewImageContainer.trailingAnchor, constant: -8),
//            viewCicle.bottomAnchor.constraint(equalTo: viewImageContainer.bottomAnchor, constant: 15),
        ])
    }
}

