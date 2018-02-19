//
//  GameManager.swift
//  Blue Box
//
//  Created by Izaak Prats on 2/19/18.
//  Copyright © 2018 Cristian Rodriguez. All rights reserved.
//

import Foundation

class GameManager {
    static let sharedInstance = GameManager()
    
    var games: [Game]

    // Computed Properties
    
    var checkedOut: [Game] { return games.filter { $0.isCheckedOut } }
    var checkedIn: [Game] { return games.filter { !$0.isCheckedOut } }
    
    init() {
        self.games = [Game]()
    }
}
