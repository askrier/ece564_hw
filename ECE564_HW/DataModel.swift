//
//  DataModel.swift
//  ECE564_HW
//
//  Created by Andrew Krier on 2/8/21.
//  Copyright © 2021 ECE564. All rights reserved.
//

import Foundation
import UIKit

enum Gender : String {
    case Male = "Male"
    case Female = "Female"
    case NonBinary = "Non-binary"
}

class Person {
    var firstName = "First"
    var lastName = "Last"
    var whereFrom = "Anywhere"  // this is just a free String - can be city, state, both, etc.
    var gender : Gender = .Male
    var hobbies = ["none"]
}

enum DukeRole : String {
    case Student = "Student"
    case Professor = "Professor"
    case TA = "Teaching Assistant"
    case Other = "Other"
}

protocol ECE564 {
    var degree : String { get }
    var languages: [String] { get }
    var team : String { get }
}

// You can add code here

/*
 * Data Structure
 */

class DukePerson: Person, CustomStringConvertible, ECE564 {
    
    var description: String {
        return "\(firstName) \(lastName) \(degree)"
    }
    
    var degree: String = ""
    
    var languages: [String] = [""]
    
    var team: String = ""
    
    var role: DukeRole = .Student
    
    //var imgString = "blank_avatar.jpg"
    var img = UIImage(named: "blank_avatar.jpg")
    
    var netID = ""
    
    var email = ""
    
    init(firstName: String, lastName: String) {
        super.init()
        self.firstName = firstName
        self.lastName = lastName
    }
    
    init(firstName: String, lastName: String, netID : String, whereFrom: String, gender: Gender, role: DukeRole, degree: String, hobbies: [String], languages: [String], team: String) {
        
        super.init()
        self.firstName = firstName
        self.lastName = lastName
        self.netID = netID
        self.whereFrom = whereFrom
        self.gender = gender
        self.role = role
        self.degree = degree
        self.hobbies = hobbies
        self.languages = languages
        self.team = team
    }
    
    init(firstName: String, lastName: String, netID : String, email: String, whereFrom: String, gender: Gender, role: DukeRole, degree: String, hobbies: [String], languages: [String], team: String, image: UIImage) {
        
        super.init()
        self.firstName = firstName
        self.lastName = lastName
        self.netID = netID
        self.email = email
        self.whereFrom = whereFrom
        self.gender = gender
        self.role = role
        self.degree = degree
        self.hobbies = hobbies
        self.languages = languages
        self.team = team
        self.img = image
    }
}
