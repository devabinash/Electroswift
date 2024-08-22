

import UIKit

class ChooseColor: UIView {
    // MARK: - Constants
    fileprivate let selectorTextColor = UIColor(named: "Write")
    fileprivate let disableTextColor = UIColor(named: "Write")
    fileprivate let selectorViewColor = UIColor(named: "Primary")
    fileprivate let disabeldViewColor = UIColor(named: "Card")
    
    // MARK: - Variables
    fileprivate var buttonElements: [UIColor] = []
    fileprivate var elementViews: [ViewColorSelect] = []

    // MARK: - Setup
    fileprivate func setupVC() {
        self.translatesAutoresizingMaskIntoConstraints = false 
        createButton()
        configStack()
    }
    
    // MARK: - Actions
    @IBAction func buttonTapped(sender: UIButton) {
        for (_, elementView) in elementViews.enumerated() {
            elementView.deselectView()
            if elementView.buttonSelect == sender {
                elementView.selectView()
            }
        }
    }
    
    // MARK: - Methods
    func setButtonColors(_ items: [UIColor]) {
        self.buttonElements = items
        self.setupVC()
    }
    
    fileprivate func createButton() {
        self.elementViews = [ViewColorSelect]()
        self.elementViews.removeAll()
        self.subviews.forEach({$0.removeFromSuperview()})
        for (_, buttonElement) in buttonElements.enumerated() {
            let view = ViewColorSelect()
            view.setColor(buttonElement)
            view.buttonSelect.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            elementViews.append(view)
        }
        elementViews[0].selectView()
    }
    
    fileprivate func configStack() {
        let stackBase = UIStackView(arrangedSubviews: elementViews)
        stackBase.axis = .horizontal
        stackBase.spacing = 8
        stackBase.distribution = .fill
        stackBase.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stackBase)
        
        NSLayoutConstraint.activate([            
            stackBase.topAnchor.constraint(equalTo: self.topAnchor),
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
