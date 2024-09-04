//
//  UserDetailVC.swift
//  JsonPlaceholderAPI
//
//  Created by Sümeyra Demirtaş on 4.09.2024.
//

import UIKit

final class UserDetailVC: UIViewController {
    
    private let viewModel: UserDetailViewModel
    private let detailView = UserDetailView()
    
    init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title

        
        // UserDetailView'u view controller'a ekliyoruz
        view.addSubview(detailView)
        detailView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        // ViewModel ile UserDetailView'u konfigure ediyoruz
        detailView.configure(with: viewModel)
    }
}
