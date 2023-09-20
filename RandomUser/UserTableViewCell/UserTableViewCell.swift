//
//  UserTableViewCell.swift
//  RandomUser
//
//  Created by Emin Emini on 20.09.2023..
//

import UIKit
import Kingfisher
import RealmSwift

class UserTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userFullNameLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    
    var viewModel = SavedUsersViewModel()
    
    var user: User!
    
    func configure(with user: User) {
        self.user = user
        userFullNameLabel.text = "\(user.name!.first) \(user.name!.last)"
        print("Thumbnail: \(String(describing: user.picture?.thumbnail))")
        if let thumbnailString = user.picture?.thumbnail,
           let thumbnailURL = URL(string: thumbnailString) {
            userImage.kf.setImage(with: thumbnailURL)
        }
    }
    
    @IBAction func saveUser(_ sender: Any) {
        //her users should be saved to CoreData
        let realm = try! Realm()
        try! realm.write {
            realm.add(user)
        }
        viewModel.loadUsers()
    }
}

