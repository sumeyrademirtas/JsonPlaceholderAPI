//
//  UserDetailViewModel.swift
//  JsonPlaceholderAPI
//
//  Created by Sümeyra Demirtaş on 4.09.2024.
//

import Foundation

struct UserDetailViewModel {
    private let user: User

    // Kullanıcı detaylarını dışa açan özellikler
    var name: String { user.name }
    var username: String { user.username }
    var email: String { user.email }
    var address: String {
        return user.address.fullAddress
    }

    var phone: String { user.phone }
    var website: String { user.website }
    var companyName: String { user.company.name }

    init(user: User) {
        self.user = user
    }
    
    public var title: String {
        user.name.uppercased()
    }
}
