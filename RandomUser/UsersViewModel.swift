//
//  UsersViewModel.swift
//  RandomUser
//
//  Created by Emin Emini on 20.09.2023..
//

import Foundation
import Alamofire

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
            case .failure(let error):
                print("Failed to fetch users: \(error.localizedDescription)")
            }
        }
    }
}


