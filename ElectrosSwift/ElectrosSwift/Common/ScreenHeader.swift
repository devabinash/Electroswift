
import UIKit

class ScreenHeader: UIView {
    // MARK: - Variables
    var title: String = "" {
        didSet {
            self.labelScreenTitle.text = title
        }
    }
    
    // MARK: - Components
    fileprivate let viewBase: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let labelScreenTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let viewBorderBottom: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.96, green: 0.97, blue: 0.97, alpha: 1.00)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    fileprivate func buildHierarchy() {
        self.addSubview(labelScreenTitle)
        self.addSubview(viewBorderBottom)
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 50),
            
            labelScreenTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            labelScreenTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            viewBorderBottom.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            viewBorderBottom.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            viewBorderBottom.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            viewBorderBottom.heightAnchor.constraint(equalToConstant: 1),
        ])
    }

}
