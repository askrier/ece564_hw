//
//  DataBase.swift
//  ECE564_HW
//
//  Created by Andrew Krier on 3/10/21.
//  Copyright © 2021 ECE564. All rights reserved.
//

import UIKit

class DataBase: NSObject {
    
    static var people = [[DukePerson]]()
    
    static func findIndexOfTeam(_ dp : DukePerson) -> Int {
        
        if people.count == 0 {
            return -1
        }
        
        for i in 0...people.count-1 {
            if people[i].count != 0 {
                if people[i][0].team.lowercased() == dp.team.lowercased() {
                    return i
                }
            }
        }
        
        return -1
    }
    
    static func add(dp : [DukePerson]) -> Void {
        for p in dp {
            add(dp: p)
        }
    }
    
    static func add(dp : DukePerson) -> Void {
        let index = findIndexOfTeam(dp)
        if index == -1 {
            people.append([dp])
        } else {
            people[index].append(dp)
        }
    }
    
    static func update(previous : DukePerson, updated : DukePerson) -> Void {
        for i in 0...people.count-1 {
            for j in 0...people[i].count-1 {
                if previous.firstName == people[i][j].firstName && previous.lastName == people[i][j].lastName {
                    people[i][j] = updated
                    return
                }
            }
        }
        
        print("ERROR did not find previous in database, should not happen")
        add(dp: updated)
        return
    }
    
    static func find(dp : DukePerson) -> DukePerson {
        for i in 0...people.count-1 {
            for j in 0...people[i].count {
                if dp.firstName == people[i][j].firstName && dp.lastName == people[i][j].lastName {
                    return people[i][j]
                }
            }
        }
        
        return DukePerson(firstName: "", lastName: "")
    }
    
    static func find(s : String) -> DukePerson {
        // TODO
        
        return DukePerson(firstName: "", lastName: "")
    }
    
    static func clear() -> Void {
        people = [[DukePerson]]()
    }
    
    static func start() -> Void {
        if let tempPeople = CodableDukePerson.loadDukePeople() {
            if tempPeople.count != 0 {
                people = [[DukePerson]]()
                for p in tempPeople {
                    add(dp: p.makeDukePerson())
                }
                return
            }
        }
        add(dp: [andrew, ric, ananjaya, kaidi])
        let _ = CodableDukePerson.saveDukePeople(list())
    }
    
    static func list() -> [DukePerson] {
        var ret : [DukePerson] = [DukePerson]()
        
        for d in people {
            ret.append(contentsOf: d)
        }
        
        return ret
    }

}
