//
//  HTTPCode.swift
//  ErrorHandlingDemo
//
//  Created by Arifin Firdaus on 24/09/20.
//  Copyright © 2020 Arifin Firdaus. All rights reserved.
//

import Foundation

struct HTTPCode {
    static let OK_200 = 200
    static let NO_CONTENT_204 = 204
    static let BAD_REQUEST_400 = 400
    static let UNAUTHORIZED_401 = 401
    static let FORBIDDEN_403 = 403
    static let NOT_FOUND_404 = 404
    static let SERVER_ERROR_500 = 500
}

struct ApiErrorCode {
    public static let unkownErrorId = -1
}

struct ApiError: Codable, Error {
    let id: Int
    let message: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case message = "message"
    }
}

