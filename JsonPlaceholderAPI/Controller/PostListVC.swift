//
//  PostListVC.swift
//  JsonPlaceholderAPI
//
//  Created by Sümeyra Demirtaş on 5.09.2024.
//

import UIKit

class PostListVC: UIViewController {
    private let viewModel: PostListViewModel
    private var collectionView: UICollectionView?



   

    // Custom initializer to pass the user ID
    init(userId: Int) {
        self.viewModel = PostListViewModel(userId: userId)
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()

        viewModel.fetchPosts { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView?.reloadData()
            }
        }
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewCompositionalLayout { _, _ in
            self.createPostSectionLayout()
        }

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.backgroundColor = .systemBackground
        collectionView?.isPagingEnabled = true
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(PostCell.self, forCellWithReuseIdentifier: PostCell.identifier)
        

        guard let collectionView = collectionView else { return }
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
//            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 16),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // Yatay kaydırma ve hücre ortalama için layout ayarı
       private func createPostSectionLayout() -> NSCollectionLayoutSection {
           let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(350))
           let item = NSCollectionLayoutItem(layoutSize: itemSize)
           item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
           
           let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(450))
           let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
           
           let section = NSCollectionLayoutSection(group: group)
           section.orthogonalScrollingBehavior = .groupPagingCentered
           
           return section
       }

}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension PostListVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.posts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCell.identifier, for: indexPath) as? PostCell else {
            fatalError("Failed to dequeue PostCell")
        }
        let post = viewModel.posts[indexPath.row]
        cell.configure(with: post)
        return cell
    }

    
}
