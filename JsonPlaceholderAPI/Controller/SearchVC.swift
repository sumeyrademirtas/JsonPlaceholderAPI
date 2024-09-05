//
//  SearchVC.swift
//  JsonPlaceholderAPI
//
//  Created by Sümeyra Demirtaş on 3.09.2024.
//

import UIKit

class SearchVC: UIViewController {
    // SearchView: Kullanıcı arayüzünü oluşturacak olan view'i tanımlıyoruz
    private let searchView = SearchView()

    // SearchViewModel: Kullanıcı sorgulama ve verileri işlemek için kullanılan ViewModel
    private let viewModel = SearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }

    private func setupUI() {
        view.addSubview(searchView)
        searchView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        searchView.searchButton.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
        searchView.showPostsButton.addTarget(self, action: #selector(didTapShowPostsButton), for: .touchUpInside)
    }

    // Search butonuna tıklandığında çalışacak fonksiyon
    @objc private func didTapSearchButton() {
        guard let userIdString = searchView.searchTextField.text,
              let userId = Int(userIdString)
        else {
            return
        }

        // ViewModel'i kullanarak API'den kullanıcı verisini çekiyoruz
        viewModel.fetchUser(by: userId) { [weak self] user in
            // Kullanıcı verisi geldikten sonra ana thread'de UI'yi güncelliyoruz
            DispatchQueue.main.async {
                if let user = user {
                    self?.searchView.userInfoLabel.text = "Name: \(user.name)\nUsername: \(user.username)\nEmail: \(user.email)"
                    self?.searchView.userInfoLabel.isHidden = false
                    self?.searchView.showPostsButton.isHidden = false
                } else {
                    self?.searchView.userInfoLabel.text = "User not found"
                    self?.searchView.userInfoLabel.isHidden = false
                    self?.searchView.showPostsButton.isHidden = true
                }
            }
        }
    }

    @objc private func didTapShowPostsButton() {
        guard let userIdString = searchView.searchTextField.text,
              let userId = Int(userIdString)
        else {
            return
        }

        let postListVC = PostListVC(userId: userId)
        navigationController?.pushViewController(postListVC, animated: true)
    }
}
