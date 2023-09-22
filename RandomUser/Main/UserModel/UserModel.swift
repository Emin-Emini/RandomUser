//
//  User.swift
//  RandomUser
//
//  Created by Emin Emini on 20.09.2023..
//

import Foundation
import RealmSwift

struct UserResult: Decodable {
    let results: [User]
}

class User: Object, Decodable {
    @objc dynamic var gender: String = ""
    @objc dynamic var name: Name?
    @objc dynamic var picture: Picture?
    @objc dynamic var dob: SinceDate?
    @objc dynamic var registered: SinceDate?
    @objc dynamic var location: Location?
    @objc dynamic var login: Login?
    @objc dynamic var email: String = ""
    @objc dynamic var phone: String = ""
}

class Name: Object, Decodable {
    @objc dynamic var first: String = ""
    @objc dynamic var last: String = ""
}

class Picture: Object, Decodable {
    @objc dynamic var large: String = ""
    @objc dynamic var medium: String = ""
    @objc dynamic var thumbnail: String = ""
}

class SinceDate: Object, Decodable {
    @objc dynamic var date: String = ""
    @objc dynamic var age: Int = 0
}

class Login: Object, Decodable {
    @objc dynamic var uuid: String = ""
    @objc dynamic var username: String = ""
}

class Location: Object, Decodable {
    @objc dynamic var street: Street?
    @objc dynamic var city: String = ""
    @objc dynamic var state: String = ""
    @objc dynamic var country: String = ""
}

class Street: Object, Decodable {
    @objc dynamic var number: Int = 0
    @objc dynamic var name: String = ""
}
