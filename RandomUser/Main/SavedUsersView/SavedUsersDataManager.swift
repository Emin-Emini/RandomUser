//
//  SavedUsersDataManager.swift
//  RandomUser
//
//  Created by Emin Emini on 22.09.2023..
//

import Foundation
import RealmSwift

class DataManager {
    static let shared = DataManager()
    
    private var savedUsers: [User] = []
    
    func getSavedUsers() -> [User] {
        return savedUsers
    }
    
    func loadSavedUsers() {
        let realm = try! Realm()
        savedUsers = Array(realm.objects(User.self))
    }
}
