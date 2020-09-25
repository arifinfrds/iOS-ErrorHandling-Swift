//
//  UserService.swift
//  ErrorHandlingDemo
//
//  Created by Arifin Firdaus on 24/09/20.
//  Copyright © 2020 Arifin Firdaus. All rights reserved.
//

import Foundation



// list user
protocol UserService {
//    func fetchUsers(completion: @escaping ([User], Error?) -> Void)
//    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void)
    func fetchUsers(completion: @escaping (Result<[User], LoadUsersError>) -> Void)
}

class UserServiceImpl: UserService {
    
    func fetchUsers(completion: @escaping ([User], Error?) -> Void) {
        let urlString = "https://jsonplaceholder.typicode.com/users/"
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, urlResponse, error) in
            if let error = error {
                completion([], error)
                return
            }
            guard let data = data else { return }

            do {
                let posts = try JSONDecoder().decode([User].self, from: data)
                completion(posts, nil)
            } catch(let error) {
                completion([], error)
            }
        }.resume()
    }
    
    func fetchUsers(completion: @escaping ((Result<[User], Error>) -> Void)) {
        let urlString = "https://jsonplaceholder.typicode.com/users/"
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, urlResponse, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            
            do {
                let posts = try JSONDecoder().decode([User].self, from: data)
                completion(.success(posts))
            } catch(let error) {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchUsers(completion: @escaping (Result<[User], LoadUsersError>) -> Void) {
        let urlString = "https://jsonplaceholder.typicode.com/users/"
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, urlResponse, error) in
            if let error = error {
                let apiError = ApiError(id: ApiErrorCode.unkownErrorId, message: error.localizedDescription)
                completion(.failure(.unknown(apiError: apiError)))
                return
            }
            guard let data = data else {
                let apiError = ApiError(id: ApiErrorCode.unkownErrorId, message: "the data is nil")
                completion(.failure(.unknown(apiError: apiError)))
                return
            }
            guard let response = urlResponse as? HTTPURLResponse else {
                let apiError = ApiError(id: ApiErrorCode.unkownErrorId, message: "not getting HTTPURLResponse")
                completion(.failure(.unknown(apiError: apiError)))
                return
            }
            if response.statusCode == HTTPCode.OK_200 {
                do {
                    let posts = try JSONDecoder().decode([User].self, from: data)
                    completion(.success(posts))
                } catch(let error) {
                    let apiError = ApiError(id: ApiErrorCode.unkownErrorId, message: error.localizedDescription)
                    completion(.failure(.unknown(apiError: apiError)))
                }
                return
            }
            if response.statusCode == HTTPCode.SERVER_ERROR_500 {
                completion(.failure(.internalServerError))
                return
            }
            // ...
            // ...
            let apiError = ApiError(id: response.statusCode, message: "Something is wrong...")
            completion(.failure(.unknown(apiError: apiError)))
        }.resume()
    }
    
}
