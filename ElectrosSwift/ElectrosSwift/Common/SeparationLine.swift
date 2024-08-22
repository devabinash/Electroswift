

import UIKit

class SeparationLine: UIView {
    // MARK: - Components
    
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
        self.backgroundColor = UIColor(red: 0.96, green: 0.97, blue: 0.97, alpha: 1.00)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Methods
    fileprivate func buildHierarchy() {
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
}
