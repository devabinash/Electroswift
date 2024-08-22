
import UIKit

protocol CouponBoxDelegate {
    func setCouponValue(_ value: Float)
}

class CouponBox: UIView {
    // MARK: - Variable
    var delegate: CouponBoxDelegate?

    // MARK: - Components
    fileprivate let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let labelCoupon: UILabel = {
        let label = UILabel()
        label.text = "Have a coupon code? enter here 👇"
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(named: "Disabled")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let labelAvailable: UILabel = {
        let label = UILabel()
        label.text = "Available"
        label.isHidden = true
        label.font = .systemFont(ofSize: 10, weight: .bold)
        label.textColor = UIColor(named: "Primary")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    fileprivate let labelUnavailable: UILabel = {
        let label = UILabel()
        label.text = "Unavailable"
        label.isHidden = true
        label.font = .systemFont(ofSize: 10, weight: .bold)
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let textFieldCoupon: UITextField = {
        let field = UITextField()
        field.placeholder = "Coupon"
        field.layer.borderColor = UIColor(red: 0.96, green: 0.97, blue: 0.97, alpha: 1.00).cgColor
        field.layer.borderWidth = 1
        field.clipsToBounds = true
        field.layer.cornerRadius = 8
        field.font = .systemFont(ofSize: 12, weight: .bold)
        field.textColor = UIColor(named: "Text")
        field.setLeftPaddingPoints(16)
        field.setRightPaddingPoints(16)
        field.autocapitalizationType = .allCharacters
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
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
        self.translatesAutoresizingMaskIntoConstraints = false
        
        textFieldCoupon.delegate = self
        
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Methods
    fileprivate func checkCode(_ code: String) {
        switch code {
        case "OFF10":
            self.delegate?.setCouponValue(10)
            self.labelAvailable.isHidden = false
            
        case "OFF15":
            self.delegate?.setCouponValue(15)
            self.labelAvailable.isHidden = false
            
        default:
            self.labelUnavailable.isHidden = false
        }
    }
    
    fileprivate func buildHierarchy() {
        self.addSubview(stackBase)
        stackBase.addArrangedSubview(labelCoupon)
        stackBase.addArrangedSubview(textFieldCoupon)
        
        self.addSubview(labelAvailable)
        self.addSubview(labelUnavailable)
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: self.topAnchor),
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            textFieldCoupon.heightAnchor.constraint(equalToConstant: 40),
            
            labelAvailable.centerYAnchor.constraint(equalTo: textFieldCoupon.centerYAnchor),
            labelAvailable.trailingAnchor.constraint(equalTo: textFieldCoupon.trailingAnchor, constant: -16),
            
            labelUnavailable.centerYAnchor.constraint(equalTo: textFieldCoupon.centerYAnchor),
            labelUnavailable.trailingAnchor.constraint(equalTo: textFieldCoupon.trailingAnchor, constant: -16),
        ])
    }

}

extension CouponBox: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.labelAvailable.isHidden = true
        self.labelUnavailable.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            return false
        }
        
        if text.count < 5 {
            return false
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let textFieldText = textField.text else { return }
        self.checkCode(textFieldText)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
              let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                  return false
              }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 5
    }
}
