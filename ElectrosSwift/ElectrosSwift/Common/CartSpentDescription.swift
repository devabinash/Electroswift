
import UIKit

class CartSpentDescription: UIView {
    // MARK: - Variables
    var text: String = "" {
        didSet {
            self.labelText.text = text
        }
    }
    
    var value: String = "" {
        didSet {
            self.labelValue.text = value
        }
    }
    
    var isFeaturedValue: Bool = false {
        didSet {
            self.setFeaturedValue(isFeaturedValue)
        }
    }
    
    // MARK: - Components
    fileprivate let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let labelText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(named: "Disabled")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let labelValue: UILabel = {
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
    fileprivate func setFeaturedValue(_ featuredValue: Bool) {
        if featuredValue {
            labelValue.font = .systemFont(ofSize: 16, weight: .bold)
            labelValue.textColor = UIColor(named: "Primary")
            return
        }
        
        labelValue.font = .systemFont(ofSize: 14, weight: .bold)
        labelValue.textColor = UIColor(named: "Text")
        return
    }
    
    fileprivate func buildHierarchy() {
        self.addSubview(stackBase)
        stackBase.addArrangedSubview(labelText)
        stackBase.addArrangedSubview(labelValue)
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
