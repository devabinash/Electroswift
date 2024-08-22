import UIKit
import SnapKit
import RxSwift

class RecentlyViewedCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants
    static let reuseIdentifier: String = "RecentlyViewedCollectionViewCell"
    
    // MARK: - UI Components
    private let baseStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fill
        return stack
    }()
    
    private let imageContainerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.backgroundColor = UIColor(red: 0.88, green: 0.94, blue: 0.98, alpha: 1.00)
        return view
    }()
    
    private let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fill
        return stack
    }()
    
    private let textStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fill
        return stack
    }()
    
    private let itemNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(named: "Text")
        return label
    }()
    
    private let itemValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(named: "Text")
        return label
    }()
    
    private let itemDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 8, weight: .regular)
        label.textColor = UIColor(named: "Disabled")
        return label
    }()
    
    private let buttonsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.backgroundColor = .white
        button.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        button.tintColor = UIColor(named: "Disabled")
        return button
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 4
        button.backgroundColor = UIColor(named: "Primary")
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupView() {
        backgroundColor = .white
        clipsToBounds = true
        layer.cornerRadius = 8
        
        buildHierarchy()
        setupConstraints()
    }
    
    // MARK: - Methods
    func configure(with item: Product) {
        itemNameLabel.text = item.name
        itemValueLabel.text = "$\(item.price)"
        itemDescriptionLabel.text = item.description
        itemImageView.image = UIImage(named: item.imagesName.first ?? "")
    }
    
    private func buildHierarchy() {
        addSubview(baseStackView)
        baseStackView.addArrangedSubview(imageContainerView)
        imageContainerView.addSubview(itemImageView)
        baseStackView.addArrangedSubview(contentStackView)
        
        contentStackView.addArrangedSubview(textStackView)
        textStackView.addArrangedSubview(itemNameLabel)
        textStackView.addArrangedSubview(itemDescriptionLabel)
        textStackView.addArrangedSubview(itemValueLabel)
        
        contentStackView.addArrangedSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(saveButton)
        buttonsStackView.addArrangedSubview(addButton)
    }
    
    private func setupConstraints() {
        baseStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageContainerView.snp.makeConstraints { make in
            make.height.equalTo(150)
        }
        
        itemImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
        saveButton.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
        
        addButton.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
    }
}
