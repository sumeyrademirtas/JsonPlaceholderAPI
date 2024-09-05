//
//  Posts.swift
//  JsonPlaceholderAPI
//
//  Created by Sümeyra Demirtaş on 5.09.2024.
//

import Foundation

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
