import UIKit
import SnapKit
import RxSwift

class DiscoverCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants
    static let reuseIdentifier: String = "DiscoverCollectionViewCell"
    
    // MARK: - UI Components
    private let baseStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        stack.distribution = .fill
        return stack
    }()
    
    private let textStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private let sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Discover"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(named: "Text")
        return label
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
        buildHierarchy()
        setupConstraints()
    }
    
    // MARK: - Methods
    private func buildHierarchy() {
        addSubview(baseStackView)
        baseStackView.addArrangedSubview(textStackView)
        textStackView.addArrangedSubview(sectionTitleLabel)
    }
    
    private func setupConstraints() {
        baseStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
