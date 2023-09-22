//
//  UsersViewModel.swift
//  RandomUser
//
//  Created by Emin Emini on 20.09.2023..
//

import Foundation
import Alamofire
import RealmSwift

class UsersViewModel {
    private var users: [User] = []
    private var currentPage = 1
    private var isFetching = false
    var didUpdateData: (() -> Void)?
    
    /// Fetches the users from the API. Uses pagination and prevents multiple requests from being sent simultaneously.
    func fetchUsers() {
        guard !isFetching else { return }  // Prevent multiple fetch requests
        isFetching = true
        APIClient.shared.performRequest(route: Router.fetchUsers(page: currentPage, results: 25)) { (result: Result<UserResult, AFError>) in
            self.isFetching = false
            switch result {
            case .success(let userResult):
                self.users += userResult.results  // Appends the fetched users to the existing array
                self.currentPage += 1  // Increment the page number for pagination
                self.didUpdateData?()  // Notify any observers that the data has updated
                self.loadUsers()  // Load users from Realm database
            case .failure(let error):
                print("Failed to fetch users: \(error.localizedDescription)")
            }
        }
    }
    
    /// Loads users from the local Realm database and notifies any observers that the data has updated.
    func loadUsers() {
        DataManager.shared.loadSavedUsers()
        didUpdateData?()
    }
    
    /// Returns the total number of users in the `users` array.
    func numberOfUsers() -> Int {
        return users.count
    }
    
    /// Returns the array of User objects.
    func getUsers() -> [User] {
        return users
    }
    
    /// Returns the User object at a specific index in the `users` array, or nil if the index is out of bounds.
    func user(at index: Int) -> User? {
        guard index >= 0 && index < users.count else {
            return nil
        }
        return users[index]
    }
}


