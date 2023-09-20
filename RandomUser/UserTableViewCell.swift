//
//  UserTableViewCell.swift
//  RandomUser
//
//  Created by Emin Emini on 20.09.2023..
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userFullNameLabel: UILabel!
    
    @IBOutlet weak var bookmarkImage: UIImageView!
    
    func configure(with user: User) {
        userFullNameLabel.text = "\(user.name.first) \(user.name.last)"
        
        // Assuming you have a function to load images from URLs
        //loadThumbnail(from: user.picture.thumbnail, into: userImageView)
    }
}

