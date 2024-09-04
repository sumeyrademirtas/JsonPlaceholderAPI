//
//  Users.swift
//  JsonPlaceholderAPI
//
//  Created by Sümeyra Demirtaş on 3.09.2024.
//

import Foundation

struct User: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
}
