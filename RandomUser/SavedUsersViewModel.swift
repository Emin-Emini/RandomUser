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
    var users: [User] = []
    var currentPage = 1
    var isFetching = false
    var didUpdateData: (() -> Void)?
    
    func loadUsers() {
        let realm = try! Realm()
        users = Array(realm.objects(User.self))
        didUpdateData?()
    }
    
    func numberOfUsers() -> Int {
        return users.count
    }
    
    func user(at index: Int) -> User? {
        guard index >= 0 && index < users.count else {
            return nil
        }
        return users[index]
    }
}
