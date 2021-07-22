//
//  CodableDukePerson.swift
//  ECE564_HW
//
//  Created by Andrew Krier on 2/17/21.
//  Copyright © 2021 ECE564. All rights reserved.
//

import UIKit

func stringFromImage(_ imagePic: UIImage) -> String {
    let picImageData: Data = imagePic.jpegData(compressionQuality: 1)!
    return picImageData.base64EncodedString()
}

func imageFromString(_ base64: String) -> UIImage {
    let picData = Data(base64Encoded: base64)
    
    if(UIImage(data: picData!) != nil) { return UIImage(data: picData!)! }
    else { return UIImage(named: "blank_avatar.jpg")! }
    
    //return UIImage(data: picData!)
}

class CodableDukePerson: NSObject, Codable {
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("DukePeopleJSONFile")
    
    var firstname: String = ""
    var lastname: String = ""
    var wherefrom: String = ""
    var gender: String = ""
    var hobbies: [String] = [String]()
    var degree: String = ""
    var languages: [String] = [String]()
    var team: String = ""
    var role: String = ""
    var picture: String = ""
    var netid: String = ""
    var email: String = ""
    var department: String = ""
    var id: String = ""

    init(firstName: String, lastName: String, whereFrom: String, gender: String, hobbies: [String], degree: String, languages: [String], team: String, role: String, imgString: String, netID: String, email: String) {
        
        self.firstname = firstName
        self.lastname = lastName
        self.netid = netID
        self.email = email
        self.wherefrom = whereFrom
        self.gender = gender
        self.role = role
        self.degree = degree
        self.hobbies = hobbies
        self.languages = languages
        self.team = team
        self.picture = imgString
        
    }
    
    func makeDukePerson() -> DukePerson {
        
        var genderEnum: Gender
        var roleEnum: DukeRole
        
        
        // Make more comprehensive
        switch gender {
        case "Male":
            genderEnum = .Male
        case "Female":
            genderEnum = .Female
        default:
            genderEnum = .NonBinary
        }
        
        switch role {
        case "Student":
            roleEnum = .Student
        case "Professor":
            roleEnum = .Professor
        case "Teaching Assistant":
            roleEnum = .TA
        case "TA":
            roleEnum = .TA
        default:
            roleEnum = .Other
        }
        
        return DukePerson(firstName: firstname, lastName: lastname, netID: netid, email: email, whereFrom: wherefrom, gender: genderEnum, role: roleEnum, degree: degree, hobbies: hobbies, languages: languages, team: team, image: imageFromString(picture))
    }
    
    static func make(_ dp : DukePerson) -> CodableDukePerson {
        return CodableDukePerson(firstName: dp.firstName, lastName: dp.lastName, whereFrom: dp.whereFrom, gender: dp.gender.rawValue, hobbies: dp.hobbies, degree: dp.degree, languages: dp.languages, team: dp.team, role: dp.role.rawValue, imgString: stringFromImage(dp.img!), netID: dp.netID, email: dp.email)
        
    }
    
    static func saveDukePeople(_ dukePeople: [DukePerson]) -> Bool {
        var codables : [CodableDukePerson] = [CodableDukePerson]()
        for dp in dukePeople {
            codables.append(make(dp))
        }
        return saveDukePeople(codables)
    }
    
    static func saveDukePeople(_ dukePeople: [CodableDukePerson]) -> Bool {
        var outputData = Data()
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(dukePeople) {
            if let _ = String(data: encoded, encoding: .utf8) {
                //print(json)
                outputData = encoded
            }
            else { return false }
            
            do {
                try outputData.write(to: ArchiveURL)
            } catch let error as NSError {
                print(error)
                return false
            }
            return true
        } else { return false }
    }
    
    static func loadDukePeople() -> [CodableDukePerson]? {
        
        let decoder = JSONDecoder()
        var dukePeople = [CodableDukePerson]()
        let tempData: Data
        
        do {
            tempData = try Data(contentsOf: ArchiveURL)
        } catch let error as NSError {
            print(error)
            return nil
        }
        if let decoded = try? decoder.decode([CodableDukePerson].self, from: tempData) {
            //print(decoded[0].firstname)
            dukePeople = decoded
        }

        return dukePeople
    }
}
