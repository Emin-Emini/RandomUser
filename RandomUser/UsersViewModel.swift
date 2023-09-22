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
    var users: [User] = []
    var currentPage = 1
    var isFetching = false
    var didUpdateData: (() -> Void)?
    
    func fetchUsers() {
        guard !isFetching else { return }
        isFetching = true
        APIClient.shared.performRequest(route: Router.fetchUsers(page: currentPage, results: 25)) { (result: Result<UserResult, AFError>) in
            self.isFetching = false
            switch result {
            case .success(let userResult):
                self.users += userResult.results
                self.currentPage += 1
                self.didUpdateData?()
                self.loadUsers()
            case .failure(let error):
                print("Failed to fetch users: \(error.localizedDescription)")
            }
        }
    }
    
    func loadUsers() {
        let realm = try! Realm()
        savedUsers = Array(realm.objects(User.self))
        didUpdateData?()
    }
    
    func numberOfUsers() -> Int {
        return users.count
    }
    
    func getUsers() -> [User] {
        return users
    }
    
    func user(at index: Int) -> User? {
        guard index >= 0 && index < users.count else {
            return nil
        }
        return users[index]
    }
}


