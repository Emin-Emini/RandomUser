//
//  UserViewModel.swift
//  RandomUser
//
//  Created by Emin Emini on 20.09.2023..
//

import Foundation
import Alamofire

class UserViewModel {
    
    var users: [User] = []
    
    func fetchUsers() {
        APIClient.shared.performRequest(route: Router.fetchUsers(page: 1, results: 25)) { (result: Result<UserResult, AFError>) in
            switch result {
            case .success(let userResult):
                self.users = userResult.results
            case .failure(let error):
                print("Failed to fetch users: \(error.localizedDescription)")
            }
        }
    }
}

