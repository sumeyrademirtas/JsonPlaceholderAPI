//
//  UserCell.swift
//  JsonPlaceholderAPI
//
//  Created by Sümeyra Demirtaş on 4.09.2024.
//
// UserCell: İsim ve kullanıcı adını üst üste yerleştirerek gösterir.

import UIKit

class UserCell: UITableViewCell {

    static let identifier = "UserCell"
    
    // UILabels for name and username
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .label
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        return label
    }()
    
    // Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Setup the UI components in the cell
    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, usernameLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    // Configure the cell with a view model
    func configure(with viewModel: UserViewModel) {
        nameLabel.text = viewModel.name
        usernameLabel.text = viewModel.username
    }
}
