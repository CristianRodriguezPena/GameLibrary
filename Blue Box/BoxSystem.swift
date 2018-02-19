//
//  BoxSystem.swift
//  Blue Box
//
//  Created by Cristian Rodriguez on 2/15/18.
//  Copyright © 2018 Cristian Rodriguez. All rights reserved.
//

import Foundation

class BoxSystem {
    let formatter = DateFormatter()
    let gameManager = GameManager.sharedInstance
    var gameSorting = "name"
    
    enum GameListFilter {
        case all
        case checkedOut
        case checkedIn
    }
    
    func launch() {
        print("""
            \(evenMiddle(text: ["ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ"]))
            \(evenMiddle(text: ["ΞΞ  Welcome To Blue Box ΞΞ"]))
            \(evenMiddle(text: ["ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ"]))
            
            """)
        
        loadDefaultGames()
        mainMenu()
    }
    
    
    func mainMenu() {
        
        formatter.dateFormat = "MM-dd-yyyy 'at' HH:mm:ss 'EST'"
        formatter.timeZone = TimeZone(abbreviation: "EST")
        
        print("""
            \(evenMiddle(text: ["ΞΞΞ   Main Menu   ΞΞΞ"]))
            
            \(evenMiddle(text: ["[1] View Library"]))
            
            \(evenMiddle(text: ["[2] Add a Game ","[3] Remove a Game"]))
            
            \(evenMiddle(text: ["[4] Check out Game","[5] Check in Game"]))
            
            \(evenMiddle(text: ["[6] [Games Checked out]","[7] Exit"]))
            
            """)
        
        addSpace(lines: 26)
        
        if let option = Int(readLine()!) {
            
            switch option {
            case 1:
                checkedInList(status: "")
            case 2:
                addGame()
            case 3:
                removeGame()
            case 4:
                checkOutGame()
            case 5:
                checkInGame()
            case 6:
                checkedInList(status: "out")
            case 7:
                print(evenMiddle(text: ["ΞΞΞΞΞ Goodbye ΞΞΞΞΞ"]))
            default:
                mainMenu()
            }
            
        } else {
            addSpace(lines: 50)
            
            mainMenu()
        }
    }
    
    func loadDefaultGames() {
        let defaultGames = [
            Game(name: "Super Mario Odyssey", genre: "Platformer", yearOfRelease: 2017, consoles: ["Nintendo Switch"], addedBy: "Blue Box"),
            Game(name: "Forza Motorsport 7", genre: "Racing", yearOfRelease: 2017, consoles: ["Xbox One"], addedBy: "Blue Box"),
            Game(name: "Breath of the Wild", genre: "Action-Adventure", yearOfRelease: 2017, consoles: ["Nintendo Switch","Wii U"], addedBy: "Blue Box"),
            Game(name: "Horizon Zero Dawn", genre: "Action", yearOfRelease: 2017, consoles: ["Playstation 4"], addedBy: "Blue Box"),
            Game(name: "Cuphead", genre: "Run & Gun", yearOfRelease: 2017, consoles: ["Xbox One"], addedBy: "Blue Box"),
            Game(name: "Destiny 2", genre: "First Person Shooter", yearOfRelease: 2017, consoles: ["Xbox One","Playstation 4","PC"], addedBy: "Blue Box"),
            Game(name: "Mario + Rabbit Kingdom", genre: "Turn-based", yearOfRelease: 2017, consoles: ["Nintendo Switch"], addedBy: "Blue Box"),
            Game(name: "Assaasins Creed: Origins", genre: "Action-Adventure", yearOfRelease: 2017, consoles: ["Xbox One","Playstation 4"], addedBy: "Blue Box"),
            Game(name: "FIFA 18", genre: "Sports", yearOfRelease: 2017, consoles: ["Xbox One","Playstation 4","Xbox 360","Playstaion 3","Nintendo Switch"], addedBy: "Blue Box"),
            Game(name: "Call of Duty: WWII", genre: "First-Person Shooter", yearOfRelease: 2017, consoles: ["Xbox One","Playstation 4"], addedBy: "Blue Box")]
        
        gameManager.games = defaultGames
    }
    
    func listGames(filter: GameListFilter) {
        let games: [Game]
        
        switch filter {
        case .all :
            games = gameManager.games
        case .checkedIn:
            games = gameManager.checkedIn
        case .checkedOut:
            games = gameManager.checkedOut
        }
        
        guard gameManager.games.count > 0 else {
            let response: String
            
            switch filter {
            case .all :
                response = "You have no games! Please add more."
            case .checkedIn:
                response = "You have no games checked in."
            case .checkedOut:
                response = "You have no games checked out."
            }
            
            print(response)
            return
        }
        
        for (index, game) in games.enumerated() {
            print("\(index + 1). \(game.name)")
        }
    }
    
    func sorting(place: String) {
        
        print(evenMiddle(text: ["The games are currently being sorted by \(gameSorting), how would you like to sort the games??"]))
        addSpace(lines: 2)
        print(evenMiddle(text: ["1) By name","2) By year ","3) by Genre"]))
        
        if let intCheck = Int(readLine()!) {
            if (1...3).contains(intCheck) {
                
                switch intCheck {
                case 2:
                    gameSorting = "year"
                    gameManager.games = gameManager.games.sorted {$0.year < $1.year}
                case 3:
                    gameSorting = "genre"
                    gameManager.games = gameManager.games.sorted {$0.genre < $1.genre}
                default:
                    gameSorting = "name"
                    gameManager.games = gameManager.games.sorted {$0.name < $1.name}
                }
            } else {
                sorting(place: place)
            }
        } else {
            sorting(place: place)
        }
    }
    
    func checkedInList(status: String) {
        
        addSpace(lines: 20)
        gameList(place: status)
        print(evenMiddle(text: ["press return to continue (enter '*' to resort the games)"]))
        addSpace(lines: 2)
        
        var checkSorting = readLine()!
        if checkSorting.contains("*") {
            sorting(place: status)
            checkedInList(status: status)
            checkSorting = ""
        }
        addSpace(lines: 20)
        mainMenu()
    }
    
    func getUserInput<T>(question: String?) -> T {
        if let question = question {
            print(question)
        }
        
        repeat {
            let input = readLine()!
            
            if T.self == Int.self {
                if let number = Int(input) {
                    return number as! T
                }
            } else {
                if let castedInput = input as? T {
                    return castedInput
                }
            }
        } while true
    }
    
    func addGame() {
        let name: String = getUserInput(question: "What is your name?")
        let gameName: String = getUserInput(question: "What is the name of the game?")
        let genre: String = getUserInput(question: "What is the genre of the game?")
        let year: Int = getUserInput(question: "What year was the game made?")
        let consoles: String = getUserInput(question: "What console(s) support the game?")
        
        let game = Game(name: gameName, genre: genre, yearOfRelease: year, consoles: [consoles], addedBy: name)
        
        gameManager.games.append(game)
        
        print("Thanks for adding \(game.name)")
        
        addSpace(lines: 10)
        mainMenu()
    }
    
    func removeGame() {
        
        gameList(place: "")
        print(evenMiddle(text: ["Please enter the number of the game you with to remove (enter '*' to resort the games)"]))
        print(evenMiddle(text: ["(enter 'Esc' to go to the main menu)"]))
        addSpace(lines: 1)
        
        let checkSorting = readLine()!
        if checkSorting.contains("*") {
            sorting(place: "")
            addSpace(lines: 10)
            removeGame()
        } else if checkSorting.lowercased().contains("esc") {
            addSpace(lines: 10)
            mainMenu()
        }
        addSpace(lines: 2)
        
        if let place = Int(checkSorting) {
            if (1...gameManager.games.count).contains(place) {
                print(evenMiddle(text: ["Are you sure you want to remove '\(gameManager.games[place - 1].name)' from the list of games?"]))
                
                if readLine()!.lowercased().contains("y") {
                    
                    print((evenMiddle(text: [gameManager.games[place - 1].name + "has been remove, Would you like to remove something else? (Yes/No)"])) )
                    gameManager.games.remove(at: place - 1)
                    
                } else {
                    removeGame()
                }
            } else {
                print("Nothing has been removed, would you like to remove something?")
            }
            if readLine()!.lowercased().contains("y") {
                removeGame()
            } else {
                addSpace(lines: 10)
                mainMenu()
            }
        } else {
            addSpace(lines: 10)
            removeGame()
            
        }
    }
    
    func checkOutGame() {
        
        gameList(place: "in")
        if currentGames.isEmpty {
            mainMenu()
        }
        print(evenMiddle(text: ["Please enter the number of the game you wish to check out (enter '*' to resort the games)"]))
        print(evenMiddle(text: ["(enter 'Esc' to back to main menu)"]))
        
        addSpace(lines: 2)
        
        let checkSorting = readLine()!
        if checkSorting.contains("*") {
            mainMenu()
        } else if checkSorting.lowercased().contains("esc") {
            mainMenu()
        }
        
        if let intCheck = Int(checkSorting) {
            if !(1...gameManager.games.filter({$0.out == false}).count).contains(intCheck) {
                checkOutGame()
            }
            let place = gameManager.games.map({$0.id}).index(of: currentGames[intCheck - 1].id)!
            if gameManager.games[place].checkOut() {
                print(evenMiddle(text: ["Are you sure you want to check out \(gameManager.games[place].name)??"]))
                
                if !readLine()!.lowercased().contains("y") {
                    gameManager.games[place].checkIn()
                    print(evenMiddle(text: ["Do you want to check something else out?"]))
                    addSpace(lines: 10)
                    if readLine()!.lowercased().contains("y") {
                        checkOutGame()
                    } else {
                        mainMenu()
                    }
                }
                
                print(evenMiddle(text: ["What is your name?"]))
                let name = readLine()!
                gameManager.games[place].checkedOutBy = name
                print(evenMiddle(text: ["'\(gameManager.games[place].name)' is now checked out to \(name)"]))
                
                addSpace(lines: 2)
                
            } else {
                print(evenMiddle(text: ["That game cannot be checked out or does not exist"]))
            }
            print(evenMiddle(text: ["Would you like to check out another game?"]))
            if !readLine()!.lowercased().contains("y") {
                addSpace(lines: 10)
                
                mainMenu()
            }
        }
        checkOutGame()
    }
    
    func checkInGame() {
        
    }
    
    //    func checkInGame() {
    //
    //        gameList(place: "out")
    //        if currentGames.isEmpty {
    //            mainMenu()
    //        }
    //        print(evenMiddle(text: ["Please enter the nunber of the game you with to check back in (enter '*' to resert the games)"]))
    //        print(evenMiddle(text: ["(Enter 'Esc' to go backto the main manu)"]))
    //
    //        let checkSorting = readLine()!
    //        if checkSorting.contains("*") {
    //            sorting(place: "in")
    //        } else if checkSorting.lowercased().contains("esc") {
    //            mainMenu()
    //        }
    //
    //        if let intCheck = Int(checkSorting) {
    //            if !(1...gameManager.games.filter({$0.out == true}).count).contains(intCheck){
    //                checkInGame()
    //            }
    //            let place = gameManager.games.map({$0.id}).index(of: currentGames[intCheck - 1].id)!
    //            if gameManager.games[place].checkIn() {
    //                print(evenMiddle(text: ["Are you sure you want to check in \(gameManager.games[place].name)??"]))
    //
    //                if !readLine()!.lowercased().contains("y") {
    //                    gameManager.games[place].checkOut()
    //                    print(evenMiddle(text: ["Do you want to check something else in?"]))
    //                    if readLine()!.lowercased().contains("y") {
    //                        checkInGame()
    //                    } else {
    //                        mainMenu()
    //                    }
    //                }
    //                print(evenMiddle(text: ["'\(gameManager.games[place].name)' is now checked back in"]))
    //
    //                addSpace(lines: 2)
    //            } else {
    //                print(evenMiddle(text: ["That game cannot be checked in or does not exist"]))
    //
    //            }
    //            print(evenMiddle(text: ["Would you like to check in another game?"]))
    //            if !readLine()!.lowercased().contains("y") {
    //                addSpace(lines: 10)
    //
    //                mainMenu()
    //            }
    //        }
    //        checkInGame()
    //    }
    
    init() {
    }
}

