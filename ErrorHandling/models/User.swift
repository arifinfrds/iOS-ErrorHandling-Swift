//
//  User.swift
//  ErrorHandlingDemo
//
//  Created by Arifin Firdaus on 24/09/20.
//  Copyright © 2020 Arifin Firdaus. All rights reserved.
//

import Foundation

// MARK: - User
struct User: Codable {
    let id: Int?
    let name: String?
    let username: String?
    let email: String?
    let address: Address?
    let phone: String?
    let website: String?
    let company: Company?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case username = "username"
        case email = "email"
        case address = "address"
        case phone = "phone"
        case website = "website"
        case company = "company"
    }
}

// MARK: - Address
struct Address: Codable {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
    let geo: Geo?

    enum CodingKeys: String, CodingKey {
        case street = "street"
        case suite = "suite"
        case city = "city"
        case zipcode = "zipcode"
        case geo = "geo"
    }
}

// MARK: - Geo
struct Geo: Codable {
    let lat: String?
    let lng: String?

    enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lng = "lng"
    }
}

// MARK: - Company
struct Company: Codable {
    let name: String?
    let catchPhrase: String?
    let bs: String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case catchPhrase = "catchPhrase"
        case bs = "bs"
    }
}
