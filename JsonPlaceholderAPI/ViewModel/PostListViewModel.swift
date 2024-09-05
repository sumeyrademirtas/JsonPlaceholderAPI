//
//  PostListViewModel.swift
//  JsonPlaceholderAPI
//
//  Created by Sümeyra Demirtaş on 5.09.2024.
//

import Foundation

class PostListViewModel {
    
    private let userId: Int
    var posts: [Post] = []
    
    init(userId: Int) {
        self.userId = userId
    }
    
    func fetchPosts(completion: @escaping () -> Void) {
        let request = Request(endpoint: .users, pathComponents: ["\(userId)", "posts"])
        
        Service.shared.execute(request, expecting: [Post].self) { [weak self] result in
            switch result {
            case .success(let posts):
                self?.posts = posts
                completion()
            case .failure(let error):
                print("Failed to fetch posts: \(error)")
            }
        }
    }
}
