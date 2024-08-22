import UIKit

class CarouselDetailsProductCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants
    static let reuseIdentifier: String = "CarouselDetailsProductCollectionViewCell"
    
    // MARK: - Components
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    /**
     Configures the cell by setting up its hierarchy and constraints.
     
     This method is responsible for initializing the visual elements of the cell,
     setting up their layout, and making sure everything is in place before the cell is used.
     */
    private func configureView() {        
        setupHierarchy()
        setupConstraints()
    }
    
    // MARK: - Methods
    /**
     Configures the cell with the provided image name.
     
     - Parameter item: The name of the image to display in the cell.
     
     This method sets the image for the productImageView based on the provided image name.
     */
    func configure(with item: String) {
        self.productImageView.image = UIImage(named: item)
    }
    
    /**
     Adds all subviews to the cell's content view.
     
     This method is responsible for adding all the necessary subviews to the container view, ensuring
     that they are part of the view hierarchy and can be displayed properly.
     */
    private func setupHierarchy() {
        self.addSubview(containerView)
        containerView.addSubview(productImageView)
    }
    
    /**
     Sets up the constraints for all subviews.
     
     This method defines the layout constraints for the container view and product image view, ensuring
     that they are correctly positioned and sized within the cell.
     */
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            productImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            productImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 250),
            productImageView.heightAnchor.constraint(equalToConstant: 250),
        ])
    }
}
