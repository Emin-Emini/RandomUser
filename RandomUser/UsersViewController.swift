//
//  UsersViewController.swift
//  RandomUser
//
//  Created by Emin Emini on 20.09.2023..
//

import UIKit
import Alamofire

class UsersViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var usersTableView: UITableView!
    
    // MARK: - Properties
    let viewModel = UsersViewModel()
    let tableView = UITableView()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        viewModel.fetchUsers()
        viewModel.didUpdateData = {
            DispatchQueue.main.async {
                self.usersTableView.reloadData()
            }
        }
    }
}

// MARK: - Table View
extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    func setupTableView() {
        usersTableView.dataSource = self
        usersTableView.delegate = self
        usersTableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        let user = viewModel.users[indexPath.row]
        cell.configure(with: user)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.users.count - 1 {
            viewModel.fetchUsers()
        }
    }
}
