//
//  Adress.swift
//  JsonPlaceholderAPI
//
//  Created by Sümeyra Demirtaş on 3.09.2024.
//

import Foundation

struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
    
    // Computed property to format the address
        var fullAddress: String {
            return "\(street), \(suite), \(city), \(zipcode)"
        }
}
