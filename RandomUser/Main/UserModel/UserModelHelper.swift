//
//  UserModelHelper.swift
//  RandomUser
//
//  Created by Emin Emini on 22.09.2023..
//

import Foundation

// User.swift
extension User {
    func deepCopy() -> User {
        let copy = User()
        copy.gender = self.gender
        copy.name = self.name?.deepCopy()
        copy.picture = self.picture?.deepCopy()
        copy.dob = self.dob?.deepCopy()
        copy.registered = self.registered?.deepCopy()
        copy.location = self.location?.deepCopy()
        copy.login = self.login?.deepCopy()
        copy.email = self.email
        copy.phone = self.phone
        return copy
    }
}

// Name.swift
extension Name {
    func deepCopy() -> Name {
        let copy = Name()
        copy.first = self.first
        copy.last = self.last
        return copy
    }
}

// Picture.swift
extension Picture {
    func deepCopy() -> Picture {
        let copy = Picture()
        copy.large = self.large
        copy.medium = self.medium
        copy.thumbnail = self.thumbnail
        return copy
    }
}

// SinceDate.swift
extension SinceDate {
    func deepCopy() -> SinceDate {
        let copy = SinceDate()
        copy.date = self.date
        copy.age = self.age
        return copy
    }
}

// Login.swift
extension Login {
    func deepCopy() -> Login {
        let copy = Login()
        copy.uuid = self.uuid
        copy.username = self.username
        return copy
    }
}

// Location.swift
extension Location {
    func deepCopy() -> Location {
        let copy = Location()
        copy.street = self.street?.deepCopy()
        copy.city = self.city
        copy.state = self.state
        copy.country = self.country
        return copy
    }
}

// Street.swift
extension Street {
    func deepCopy() -> Street {
        let copy = Street()
        copy.number = self.number
        copy.name = self.name
        return copy
    }
}
