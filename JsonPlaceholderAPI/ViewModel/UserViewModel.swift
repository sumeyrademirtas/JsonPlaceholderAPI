//
//  UserCellViewModel.swift
//  JsonPlaceholderAPI
//
//  Created by Sümeyra Demirtaş on 3.09.2024.
//
// UserViewModel: Her hücre için isim ve kullanıcı adını sağlar.

import Foundation

struct UserViewModel {
    let name: String
    let username: String

    init(user: User) {
        self.name = user.name
        self.username = user.username
    }
}
