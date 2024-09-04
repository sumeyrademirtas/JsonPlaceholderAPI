//
//  SearchView.swift
//  JsonPlaceholderAPI
//
//  Created by Sümeyra Demirtaş on 4.09.2024.
//

import UIKit

class SearchView: UIView {

    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter user ID"
        textField.borderStyle = .roundedRect
        return textField
    }()

    let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Search", for: .normal)
        button.configuration = .filled() // Default filled button
        return button
    }()

    let userInfoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()

    let showPostsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show Posts", for: .normal)
        button.isHidden = true
        button.configuration = .filled() // Default filled button
        button.configuration?.baseBackgroundColor = .systemCyan
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [searchTextField, searchButton, userInfoLabel, showPostsButton])
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .center
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])

        searchTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
    }
}
