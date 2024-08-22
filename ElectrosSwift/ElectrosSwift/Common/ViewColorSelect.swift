
import UIKit

class ViewColorSelect: UIView {
    // MARK: - Components
    fileprivate let viewColor: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 12.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var buttonSelect: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        self.clipsToBounds = true
        self.layer.cornerRadius = 15        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Methods
    func deselectView() {
        self.layer.borderWidth = 0
    }
    
    func selectView() {
        self.layer.borderWidth = 1
    }
    
    func setColor(_ color: UIColor) {
        self.layer.borderColor = color.cgColor
        self.viewColor.backgroundColor = color
    }
    
    fileprivate func buildHierarchy() {
        self.addSubview(viewColor)
        viewColor.addSubview(buttonSelect)
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 30),
            self.heightAnchor.constraint(equalToConstant: 30),
            
            viewColor.widthAnchor.constraint(equalToConstant: 25),
            viewColor.heightAnchor.constraint(equalToConstant: 25),
            viewColor.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            viewColor.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            buttonSelect.topAnchor.constraint(equalTo: viewColor.topAnchor),
            buttonSelect.leadingAnchor.constraint(equalTo: viewColor.leadingAnchor),
            buttonSelect.trailingAnchor.constraint(equalTo: viewColor.trailingAnchor),
            buttonSelect.bottomAnchor.constraint(equalTo: viewColor.bottomAnchor),
        ])
    }

}
