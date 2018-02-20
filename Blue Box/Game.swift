//
//  Game.swift
//  Blue Box
//
//  Created by Cristian Rodriguez on 2/9/18.
//  Copyright © 2018 Cristian Rodriguez. All rights reserved.
//

import Foundation

class Game: BoxSystem {
    var name: String
    var genre: String
    var year: String
    var consoles: [String]
    var out = false
    var outDate = Date()
    var dueDate = Date(timeIntervalSinceReferenceDate: Date().timeIntervalSinceReferenceDate * 100)
    var addedBy : String
    let id : String
    var checkedOutBy = ""

    func checkOut() -> Bool {
        if !out {
            outDate = Date()
            dueDate = Date(timeIntervalSinceReferenceDate: outDate.timeIntervalSinceReferenceDate + 150)
            out = true
        }
        return out
    }
    
    func checkIn() -> Bool {
        if out {
            out = false
            dueDate = Date(timeIntervalSinceReferenceDate: Date().timeIntervalSinceReferenceDate * 100)
        }
        return !out
    }
    
    init(name: String, genre: String, yearOfRelease: String, consoles: [String], addedBy: String, id: Int) {
        self.name = name
        self.genre = genre
        self.year = yearOfRelease
        self.consoles = consoles
        self.addedBy = addedBy
        self.id = String(id)
    }
}

