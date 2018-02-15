//
//  Unit.swift
//  Blue Box
//
//  Created by Cristian Rodriguez on 2/9/18.
//  Copyright © 2018 Cristian Rodriguez. All rights reserved.
//

import Foundation

class Game: BoxSystem {
    var name: String
    var genre: String
    var year: Int
    var consoles: [String]
    var out: Bool
    var dueDate = Date()
    func check(t: Bool) -> Bool {
        if t {
            if !out {
                dueDate = Date()
                out = true
            }
        } else {
            if out {
                out = false
                if Date().timeIntervalSinceNow - dueDate.timeIntervalSinceNow > 150 {
                    for _ in 1...20 {
                        print(mid(t: ["THE GAME WAS LATE!!!!"]))
                        wait(s: 0.1)
                    }
                }
            }
        }
        return t && !out
    }
    init(Name: String, Genre: String, YearOfRelease: Int, Consoles: [String]) {
        self.name = Name
        self.genre = Genre
        self.year = YearOfRelease
        self.out = false
        self.consoles = Consoles
    }
}

