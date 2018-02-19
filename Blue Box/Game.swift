//
//  Game.swift
//  Blue Box
//
//  Created by Cristian Rodriguez on 2/9/18.
//  Copyright © 2018 Cristian Rodriguez. All rights reserved.
//

import Foundation

class Game: BoxSystem, Rentable {
    let name: String
    let genre: String
    let year: Int
    let consoles: [String]
    let addedBy: String
    
    // Check out properties
    var isCheckedOut: Bool { return checkedOut != nil }
    var checkedOut: Date? {
        didSet {
            guard let checkedOut = checkedOut else {
                self.due = nil
                return
            }
            self.due = Date(timeIntervalSinceReferenceDate: checkedOut.timeIntervalSinceReferenceDate + 150)
        }
    }
    var due: Date?
    var late: Bool? {
        guard let due = due else { return nil }
        return Date() > due
    }

    // MARK: Functions
    
    func checkOut() throws {
        guard checkedOut == nil else {
            throw RentableError.alreadyCheckedOut
        }
        
        self.checkedOut = Date()
    }
    
    func checkIn() throws {
        guard checkedOut != nil else {
            throw RentableError.notCheckedOut
        }
        
        self.checkedOut = nil
    }
    
    init(name: String, genre: String, yearOfRelease: Int, consoles: [String], addedBy: String) {
        self.name = name
        self.genre = genre
        self.year = yearOfRelease
        self.consoles = consoles
        self.addedBy = addedBy
        self.checkedOut = nil
        self.due = nil
    }
    
    init(name: String, genre: String, yearOfRelease: Int, consoles: [String], addedBy: String, checkedOut: Date?, due: Date?) {
        self.name = name
        self.genre = genre
        self.year = yearOfRelease
        self.consoles = consoles
        self.addedBy = addedBy
        self.checkedOut = checkedOut
        self.due = due
    }
}

