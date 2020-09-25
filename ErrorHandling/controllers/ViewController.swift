//
//  ViewController.swift
//  ErrorHandling
//
//  Created by Arifin Firdaus on 25/09/20.
//  Copyright © 2020 Arifin Firdaus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak private var tableView: UITableView!
    private let cellId = "cell"
    
    private let service: UserService = UserServiceImpl()
    private var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchUsers()

    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    func fetchUsers() {
        service.fetchUsers { result in
            switch result {
            case .success(let posts):
                self.users = posts
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}


// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        return cell
    }
    
}


// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


