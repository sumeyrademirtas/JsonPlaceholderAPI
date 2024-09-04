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
    
    // Fetch users dynamically using Service, Request, and PhEndPoint
    
    func fetchUsers() {
        
        let request = Request(endpoint: .users) // Assuming .users is an endpoint in PhEndPoint
        
        // Service.shared.execute, arka planda URLSession ile API isteği gönderir.
        Service.shared.execute(request, expecting: [User].self) { [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
                self?.didFetchUsers?()
            case .failure(let error):
                print("Failed to fetch users: \(error)")
            }
        }
        
    }
    
    
    
    // Return a UserViewModel for each row
    func userViewModel(at index: Int) -> UserViewModel {
        let user = users[index]
        return UserViewModel(user: user)
    }
    
}
