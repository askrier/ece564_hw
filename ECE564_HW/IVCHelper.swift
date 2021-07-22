//
//  IVCHelper.swift
//  ECE564_HW
//
//  Created by Andrew Krier on 2/20/21.
//  Copyright © 2021 ECE564. All rights reserved.
//

import UIKit

/*
 * COLORS!!!!
 */

extension UIColor {
    static let attributeColor = UIColor(red: 127/256, green: 121/256, blue: 121/256, alpha: 1)
    static let textColor = UIColor(red: 61/256, green: 59/256, blue: 60/256, alpha: 1)
    static let backgroundColor = UIColor(red: 193/256, green: 189/256, blue: 179/256, alpha: 1)
    static let buttonSliderColor = UIColor(red: 50/256, green: 48/256, blue: 49/256, alpha: 1)
    static let sliderColor = UIColor(red: 95/256, green: 91/256, blue: 107/256, alpha: 1)
    static let buttonTextColor = UIColor(red: 236/256, green: 229/256, blue: 240/256, alpha: 1)
    static let grassGreen = UIColor(red: 124/256, green: 252/256, blue: 0, alpha: 1)
    static let skyBlue = UIColor(red: 135/256, green: 206/256, blue: 235/265, alpha: 1)
}

/*
 * Prelim Database
 */

var kaidi = DukePerson(firstName: "Kaidi", lastName: "Lyu", netID: "kl347", email: "kl347@duke.edu", whereFrom: "China", gender: .Male, role: .TA, degree: "Grad", hobbies: ["Hiking", "Swimming", "Biking"], languages: ["Swift", "Java", "C++"], team: "None", image: UIImage(named: "kaidi.jpg")!)
var ananjaya = DukePerson(firstName: "Ananjaya", lastName: "Tyagi", netID: "at334", email: "at334@duke.edu", whereFrom: "India", gender: .Female, role: .TA, degree: "Grad", hobbies: ["Reading", "Watching Movies"], languages: ["Java", "Swift", "Python"], team: "None", image: UIImage(named: "ananjaya.jpg")!)
var ric = DukePerson(firstName: "Richard", lastName: "Telford", netID: "rt113", email: "rt113@duke.edu", whereFrom: "Chatham County, NC", gender: .Male, role: .Professor, degree: "N/A", hobbies: ["Swimming", "Reading", "Golf"], languages: ["Swift", "C", "C++"], team: "None", image: UIImage(named: "ric.jpg")!)
var andrew = DukePerson(firstName: "Andrew", lastName: "Krier", netID: "ak513", email: "ak513@duke.edu", whereFrom: "Saint Paul, MN", gender: .Male, role: .Student, degree: "Undergrad", hobbies: ["Basketball", "Frisbee"], languages: ["Java", "Python", "Swift"], team: "treaddit", image: UIImage(named: "krier.jpg")!)

/*
 * REST and HTTPS Calls
 */

let token = "E16992BE64C3CA17E931920F00807BC2"
let username = "ak513"
let loginString = "\(username):\(token)"
let uploadString = "https://rt113-dt01.egr.duke.edu:5640/b64entries"

/*
 * Helper functions and objects
 */

func makeString(p: DukePerson) -> String {
    if p.firstName == "" && p.lastName == "" {
        return ""
    }
    
    var he : String
    var are : String
    var know : String
    
    switch p.gender {
    case .Male:
        he = "He"
        are = "is"
        know = "knows"
    case .Female:
        he = "She"
        are = "is"
        know = "knows"
    case .NonBinary:
        he = "They"
        are = "are"
        know = "know"
    }
    var deg : String
    if(p.degree == "N/A") {
        deg = ""
    } else {
        deg = p.degree + " "
    }
    
    var email : String
    if(p.email == "") {
        email = ""
    } else {
        email = "\(he) can be reached at \(p.email)"
    }
    
    return "\(p.firstName) \(p.lastName) \(are) from \(p.whereFrom). \(he) \(are) a \(deg)\(p.role) who enjoys \(listToString(s: p.hobbies)). \(he) \(know) \(listToString(s: p.languages)) and \(are) on team \(p.team). \(email)"
}

func listToString(s : [String]) -> String {
    var ret = ""
    
    if s.count == 0 { return "nothing" }
    if s.count == 1 {
        if(s[0] == "") { return "nothing" }
        return s[0]
    }
    else {
        for i in 1...s.count {
            if(i == 1) {
                ret = s[s.count - i]
            } else if(i == 2) {
                ret = s[s.count - i] + " and " + ret
            } else {
                ret = s[s.count - i] + ", " + ret
            }
        }
    }
    
    return ret
    
}

func idToEmail(s: String) -> String {
    if(s == "") { return "" }
    return s + "@duke.edu"
}

func makePersonWithCurrent() -> DukePerson {
    
    if let first = fNameTextBox.text, let last = lNameTextBox.text {
        let p = DukePerson(firstName: first, lastName: last)
        
        if let from = homeTextBox.text {
            p.whereFrom = from
        }
        
        if let email = emailTextBox.text {
            p.email = email
        }
        
        if let ID = netIDTextBox.text {
            p.netID = ID
            if(ID != "" && p.email == "") { p.email = idToEmail(s: ID) }
        }
        
        switch genderPicker.selectedSegmentIndex {
        case 0:
            p.gender = .Male
        case 1:
            p.gender = .Female
        default:
            p.gender = .NonBinary
        }
        
        switch rolePicker.selectedSegmentIndex {
        case 0:
            p.role = .Professor
        case 1:
            p.role = .TA
        case 2:
            p.role = .Student
        default:
            p.role = .Other
        }
        
        switch degreePicker.selectedSegmentIndex {
        case 0:
            p.degree = "Undergrad"
        case 1:
            p.degree = "Grad"
        default:
            p.degree =  "N/A"
        }
        
        if let hobbies = hobbiesTextBox.text {
            p.hobbies = hobbies.components(separatedBy: ", ")
        }
        
        if let langs = langTextBox.text {
            p.languages = langs.components(separatedBy: ", ")
        }
        
        if let team = teamTextBox.text {
            p.team = team
        }
        
        if let picture = imageButton.currentImage {
            p.img = picture
        }
        
        return p
    }
    
    return DukePerson(firstName: "", lastName: "")
}


func updatePerson(p: DukePerson) -> Void {
    currentPerson = p
    
    switch p.gender {
    case .Male:
        genderIndex = 0
    case .Female:
        genderIndex = 1
    default:
        genderIndex = 2
    }
    
    switch p.role {
    case .Professor:
        roleIndex = 0
    case .TA:
        roleIndex = 1
    case .Student:
        roleIndex = 2
    default:
        roleIndex = 3
    }
    
    switch p.degree {
    case "Undergrad":
        degreeIndex = 0
    case "Grad":
        degreeIndex = 1
    case "N/A":
        degreeIndex = 2
    default:
        degreeIndex = 0
    }
    
    hobbiesString = ""
    
    if(p.hobbies.count != 0) {
        for i in 1...p.hobbies.count {
            if(i != 1) {
                hobbiesString += ", "
            }
            hobbiesString += p.hobbies[i-1]
        }
    }
    
    langString = ""
    
    if(p.hobbies.count != 0) {
        for i in 1...p.languages.count {
            if(i != 1) {
                langString += ", "
            }
            langString += p.languages[i-1]
        }
    }
    
    text = makeString(p: p)
    
    image = p.img
}
