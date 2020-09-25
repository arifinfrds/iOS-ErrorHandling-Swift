//
//  LoadUsersError.swift
//  ErrorHandlingDemo
//
//  Created by Arifin Firdaus on 25/09/20.
//  Copyright © 2020 Arifin Firdaus. All rights reserved.
//

import Foundation

enum LoadUsersError: Error {
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case internalServerError
    case requestTimeout
    case noInternetConnection
    case unknown(apiError: ApiError)
}
