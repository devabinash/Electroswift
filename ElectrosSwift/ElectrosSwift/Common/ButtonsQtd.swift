

import UIKit

protocol ButtonsQtdDelegate {
    func updateQtd(_ qtd: Int)
}

class ButtonsQtd: UIView {
    // MARK: - Variables
    var qtdSelected: Int = 1
    
    var delegate: ButtonsQtdDelegate?

    // MARK: - Components
    fileprivate let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let buttonMinus: UIButton = {
        let button = UIButton()
        button.tag = 0
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "Primary")?.cgColor
        button.backgroundColor = .clear
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.tintColor = UIColor(named: "Primary")
        button.addTarget(self, action: #selector(buttonsTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate let labelQtd: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let buttonPlus: UIButton = {
        let button = UIButton()
        button.tag = 1
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(named: "Primary")
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(buttonsTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Actions
    @IBAction func buttonsTapped(sender: UIButton) {
        if sender.tag == 0 {
            if qtdSelected - 1 < 1 {
                return
            }
            qtdSelected -= 1
        }
        else {
            qtdSelected += 1
        }
        
        self.labelQtd.text = "\(self.qtdSelected)"
        self.delegate?.updateQtd(self.qtdSelected)
    }
    
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
        self.translatesAutoresizingMaskIntoConstraints = false
        
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Methods
    func setQtd(_ qtd: Int) {
        self.qtdSelected = qtd
        self.labelQtd.text = "\(qtd)"
    }
    
    fileprivate func buildHierarchy() {
        self.addSubview(stackBase)
        stackBase.addArrangedSubview(buttonMinus)
        stackBase.addArrangedSubview(labelQtd)
        stackBase.addArrangedSubview(buttonPlus)
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackBase.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            buttonMinus.widthAnchor.constraint(equalToConstant: 25),
            buttonMinus.heightAnchor.constraint(equalToConstant: 25),
            
            labelQtd.widthAnchor.constraint(equalToConstant: 30),
            
            buttonPlus.widthAnchor.constraint(equalToConstant: 25),
            buttonPlus.heightAnchor.constraint(equalToConstant: 25),
        ])
    }

}
