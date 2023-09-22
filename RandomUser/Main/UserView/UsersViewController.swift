//
//  UsersViewController.swift
//  RandomUser
//
//  Created by Emin Emini on 20.09.2023..
//

import UIKit
import Alamofire
import RealmSwift

class UsersViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var usersTableView: UITableView!
    
    // MARK: - Properties
    let viewModel = UsersViewModel()
    let tableView = UITableView()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupTableView()
        viewModel.fetchUsers()
        viewModel.didUpdateData = {
            DispatchQueue.main.async {
                self.usersTableView.reloadData()
            }
        }
        NotificationCenter.default.addObserver(self, selector: #selector(userSavedOrRemoved), name: NSNotification.Name(rawValue: "userSavedOrRemoved"), object: nil)
    }
}

// MARK: - Functions
extension UsersViewController {
    @objc func userSavedOrRemoved() {
        DispatchQueue.main.async {
            self.usersTableView.reloadData()
        }
    }
}

// MARK: - Table View
extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
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
        let user = viewModel.user(at: indexPath.row)
        
        cell.user = user
        cell.didUpdate = { [weak self] in
            DispatchQueue.main.async {
                // Re-check if the user is saved
                //let isUpdatedSaved = self?.isSaved(user: user) ?? false
                //cell.configure(with: user, isSaved: isUpdatedSaved)
                
                self?.usersTableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.numberOfUsers() - 1 {
            viewModel.fetchUsers()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedUser = viewModel.user(at: indexPath.row)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "UserDetails", bundle: nil)
        let userDetailsViewController = storyBoard.instantiateViewController(withIdentifier: "UserDetailsViewController") as! UserDetailsViewController
        userDetailsViewController.user = selectedUser
        self.present(userDetailsViewController, animated: true, completion: nil)
    }
}
