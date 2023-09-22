//
//  UserTableViewCell.swift
//  RandomUser
//
//  Created by Emin Emini on 20.09.2023..
//

import UIKit
import Kingfisher
import RealmSwift

protocol UserTableViewCellDelegate: AnyObject {
    func userDidUpdate()
}

class UserTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userFullNameLabel: UILabel!
    @IBOutlet weak var bookmarkImage: UIImageView!
    @IBOutlet weak var bookmarkButton: UIButton!
    
    var userViewModel = UsersViewModel()
    var savedViewModel = SavedUsersViewModel()
    
    var user: User! {
        didSet {
            guard let user = user else { return }
            
            userFullNameLabel.text = "\(user.name!.first) \(user.name!.last)"
            
            if let thumbnailString = user.picture?.thumbnail,
               let thumbnailURL = URL(string: thumbnailString) {
                userImage.kf.setImage(with: thumbnailURL)
            }

            // Check if user is saved
            let realm = try! Realm()
            userSaved = isUserSaved(in: realm, uuid: user.login?.uuid ?? "")
        }
    }
    
    var userSaved: Bool = false {
        didSet {
            bookmarkImage.image = userSaved ? UIImage(named: "saved") : UIImage(named: "unsaved")
        }
    }
    
    var didUpdate: (() -> Void)?
    
    func isUserSaved(in realm: Realm, uuid: String) -> Bool {
        let predicate = NSPredicate(format: "login.uuid = %@", uuid)
        return realm.objects(User.self).filter(predicate).count > 0
    }
    
    // UserTableViewCell.swift
    @IBAction func saveUser(_ sender: Any) {
        let realm = try! Realm()
        let predicate = NSPredicate(format: "login.uuid = %@", user.login?.uuid ?? "")
        
        try! realm.write {
            if let existingUser = realm.objects(User.self).filter(predicate).first {
                realm.delete(existingUser)
                userSaved = false
            } else {
                let userCopy = user.deepCopy()
                realm.add(userCopy)
                userSaved = true
            }
        }
        
        didUpdate?()
    }
}
