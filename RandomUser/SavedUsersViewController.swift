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
    
    func isSaved(user: User) -> Bool {
        let realm = try! Realm()
        let predicate = NSPredicate(format: "uuid = %@", user.login?.uuid ?? "")
        return realm.objects(Login.self).filter(predicate).count > 0
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
        
        cell.user = user
        cell.didUpdate = {
            self.viewModel.loadUsers() // or any other method to update your list
            self.usersTableView.reloadData()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "userSavedOrRemoved"), object: nil)
        }
        
        return cell
    }
}
