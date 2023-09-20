//
//  SavedUsersViewController.swift
//  RandomUser
//
//  Created by Emin Emini on 20.09.2023..
//

import UIKit
import RealmSwift

class SavedUsersViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var usersTableView: UITableView!
    
    // MARK: - Properties
    let viewModel = SavedUsersViewModel()
    let tableView = UITableView()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupTableView()
        viewModel.loadUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadUsers()
        viewModel.didUpdateData = {
            DispatchQueue.main.async {
                self.usersTableView.reloadData()
            }
        }
    }
}

// MARK: - Table View
extension SavedUsersViewController: UITableViewDataSource, UITableViewDelegate {
    func setupTableView() {
        usersTableView.dataSource = self
        usersTableView.delegate = self
        usersTableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
        usersTableView.rowHeight = 80
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfUsers()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        guard let user = viewModel.user(at: indexPath.row) else {
            return UITableViewCell()
        }
        cell.configure(with: user)
        
        return cell
    }
}
