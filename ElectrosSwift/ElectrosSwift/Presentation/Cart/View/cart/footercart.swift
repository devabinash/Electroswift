import UIKit

class CartFooterView: UICollectionReusableView {
    // MARK: - Constants
    static let reuseIdentifier: String = "CartFooterView"
    
    // MARK: - Variables
    private var itemSubtotal: Float = 0 {
        didSet {
            calculateOrderTotal()
        }
    }
    private var couponDiscount: Float = 0 {
        didSet {
            calculateOrderTotal()
        }
    }
    private var shippingFee: Float = 10.00
    private var orderTotal: Float = 0
    
    // MARK: - Components
    private let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 24
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let auxiliaryView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let couponInputView: CouponBox = {
        let view = CouponBox()
        return view
    }()
    
    private let costBreakdownStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let itemSubtotalLabel: CartSpentDescription = {
        let label = CartSpentDescription()
        label.text = "Subtotal:"
        return label
    }()
    
    private let shippingFeeLabel: CartSpentDescription = {
        let label = CartSpentDescription()
        label.text = "Delivery Fee:"
        return label
    }()
    
    private let couponDiscountLabel: CartSpentDescription = {
        let label = CartSpentDescription()
        label.text = "Discount:"
        return label
    }()
    
    private let paymentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let separatorLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let orderTotalLabel: CartSpentDescription = {
        let label = CartSpentDescription()
        label.text = "Total:"
        label.isFeaturedValue = true
        return label
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(named: "Primary")
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        separatorLine.makeDashedBorderLine()
    }
    
    // MARK: - Setup
    private func configureView() {
        couponInputView.delegate = self
        
        updateValues()
        setupHierarchy()
        setupConstraints()
    }
    
    // MARK: - Methods
    func configureCell(subtotal: Float) {
        self.itemSubtotal = subtotal
    }
    
    private func calculateOrderTotal() {
        self.orderTotal = self.itemSubtotal + shippingFee - couponDiscount
        updateValues()
    }
    
    private func updateValues() {
        itemSubtotalLabel.value = "$\(itemSubtotal)"
        shippingFeeLabel.value = "$\(shippingFee)"
        couponDiscountLabel.value = "$\(couponDiscount)"
        orderTotalLabel.value = "$\(orderTotal)"
    }
    
    private func setupHierarchy() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(couponInputView)
        
        mainStackView.addArrangedSubview(costBreakdownStack)
        costBreakdownStack.addArrangedSubview(itemSubtotalLabel)
        costBreakdownStack.addArrangedSubview(shippingFeeLabel)
        costBreakdownStack.addArrangedSubview(couponDiscountLabel)
        
        mainStackView.addArrangedSubview(separatorLine)
        
        mainStackView.addArrangedSubview(paymentStackView)
        paymentStackView.addArrangedSubview(orderTotalLabel)
        paymentStackView.addArrangedSubview(continueButton)
        mainStackView.addArrangedSubview(auxiliaryView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            continueButton.heightAnchor.constraint(equalToConstant: 45),
            
            separatorLine.heightAnchor.constraint(equalToConstant: 2),
        ])
    }
}

extension CartFooterView: CouponBoxDelegate {
    func setCouponValue(_ value: Float) {
        self.couponDiscount = value
    }
}
