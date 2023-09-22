//
//  SavedUsersViewModel.swift
//  RandomUser
//
//  Created by Emin Emini on 20.09.2023..
//

import Foundation
import Alamofire
import RealmSwift

class SavedUsersViewModel {
    
    private var currentPage = 1
    private var isFetching = false
    var didUpdateData: (() -> Void)?
    
    /// Loads users from the local Realm database and notifies any observers that the data has updated.
    func loadUsers() {
        DataManager.shared.loadSavedUsers()
        didUpdateData?()
    }
    
    /// Returns the total number of saved users
    func numberOfUsers() -> Int {
        let users = DataManager.shared.getSavedUsers()
        return users.count
    }
    
    /// Returns a saved user at specific index
    func user(at index: Int) -> User? {
        let users = DataManager.shared.getSavedUsers()
        guard index >= 0 && index < users.count else {
            return nil
        }
        return users[index]
    }
}
