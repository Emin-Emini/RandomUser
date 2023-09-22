//
//  SavedUsersViewModel.swift
//  RandomUser
//
//  Created by Emin Emini on 20.09.2023..
//

import Foundation
import Alamofire
import RealmSwift

var savedUsers: [User] = []

class SavedUsersViewModel {
    
    var currentPage = 1
    var isFetching = false
    var didUpdateData: (() -> Void)?
    
    func loadUsers() {
        let realm = try! Realm()
        savedUsers = Array(realm.objects(User.self))
        didUpdateData?()
    }
    
    func numberOfUsers() -> Int {
        return savedUsers.count
    }
    
    func user(at index: Int) -> User? {
        guard index >= 0 && index < savedUsers.count else {
            return nil
        }
        return savedUsers[index]
    }
}
