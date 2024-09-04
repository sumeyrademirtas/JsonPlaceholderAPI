//
//  UserListViewModel.swift
//  JsonPlaceholderAPI
//
//  Created by Sümeyra Demirtaş on 4.09.2024.
//
// UsersListViewModel: API’den kullanıcıları çeker ve verileri view controller için hazırlar.

import Foundation

class UsersListViewModel {
    
    // Array to hold the users data
    var users: [User] = []
    
    // Closure to notify the view controller when data is fetched
    var didFetchUsers: (() -> Void)?

    func fetchUsers() {
        // Simulate API call
        // Replace with your API service call
        let urlString = "https://jsonplaceholder.typicode.com/users"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                print("Failed to fetch users:", error)
                return
            }
            
            guard let data = data else { return }
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                self?.users = users
                self?.didFetchUsers?()
            } catch {
                print("Failed to decode users:", error)
            }
        }.resume()
    }

    // Returns a UserViewModel for a specific row
    func userViewModel(at index: Int) -> UserViewModel {
        let user = users[index]
        return UserViewModel(user: user)
    }
}
