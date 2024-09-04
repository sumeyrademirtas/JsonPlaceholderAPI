import UIKit

final class UserDetailView: UIView {
    // MARK: - Properties
    
    private let emailLabel = UILabel()
    private let addressLabel = UILabel()
    private let phoneLabel = UILabel()
    private let websiteLabel = UILabel()
    private let companyNameLabel = UILabel()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        // Create rows for each detail
        let emailRow = createRow(iconName: "envelope.fill", title: "Email", label: emailLabel)
        let addressRow = createRow(iconName: "house.fill", title: "Address", label: addressLabel)
        let phoneRow = createRow(iconName: "phone.fill", title: "Phone", label: phoneLabel)
        let websiteRow = createRow(iconName: "globe", title: "Website", label: websiteLabel)
        let companyRow = createRow(iconName: "building.2.fill", title: "Company", label: companyNameLabel)
        
        // StackView to hold all rows
        let stackView = UIStackView(arrangedSubviews: [emailRow, addressRow, phoneRow, websiteRow, companyRow])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        // Constraints
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    // MARK: - Helpers
    
    private func createRow(iconName: String, title: String, label: UILabel) -> UIStackView {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(systemName: iconName)
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        // Configure label to be right-aligned
        label.textAlignment = .right
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.numberOfLines = 0
        // Adding width constraints to the label to allow for line wrapping
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(lessThanOrEqualToConstant: UIScreen.main.bounds.width * 0.4) // Set max width of label
        ])
            
        let stackView = UIStackView(arrangedSubviews: [iconImageView, titleLabel, label])
        stackView.axis = .horizontal
        stackView.spacing = 16
//        stackView.distribution = .fill
        stackView.alignment = .top // Align the labels to the top
        stackView.distribution = .fillProportionally
            
        return stackView
    }
    
    // MARK: - Configure
    
    public func configure(with viewModel: UserDetailViewModel) {
        emailLabel.text = viewModel.email
        addressLabel.text = viewModel.address
        phoneLabel.text = viewModel.phone
        websiteLabel.text = viewModel.website
        companyNameLabel.text = viewModel.companyName
    }
}
