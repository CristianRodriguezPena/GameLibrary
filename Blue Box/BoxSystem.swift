//
//  BoxSystem.swift
//  Blue Box
//
//  Created by Cristian Rodriguez on 2/15/18.
//  Copyright © 2018 Cristian Rodriguez. All rights reserved.
//

import Foundation


class BoxSystem {
    var listOfGames = [Game]()
    var currentGames = [Game]()
    let formatter = DateFormatter()
    var gameSorting = "name"

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
        
        listOfGames.append(Game(name: "Super Mario Odyssey", genre: "Platformer", yearOfRelease: "2017", consoles: ["Nintendo Switch"], addedBy: "Blue Box", id: 0))
        listOfGames.append(Game(name: "Forza Motorsport 7", genre: "Racing", yearOfRelease: "2017", consoles: ["Xbox One"], addedBy: "Blue Box", id: listOfGames.count + 1))
        listOfGames.append(Game(name: "Breath of the Wild", genre: "Action-Adventure", yearOfRelease: "2017", consoles: ["Nintendo Switch","Wii U"], addedBy: "Blue Box", id: listOfGames.count + 1))
        listOfGames.append(Game(name: "Horizon Zero Dawn", genre: "Action", yearOfRelease: "2017", consoles: ["Playstation 4"], addedBy: "Blue Box", id: listOfGames.count + 1))
        listOfGames.append(Game(name: "Cuphead", genre: "Run & Gun", yearOfRelease: "2017", consoles: ["Xbox One"], addedBy: "Blue Box", id: listOfGames.count + 1))
        listOfGames.append(Game(name: "Destiny 2", genre: "First Person Shooter", yearOfRelease: "2017", consoles: ["Xbox One","Playstation 4","PC"], addedBy: "Blue Box", id: listOfGames.count + 1))
        listOfGames.append(Game(name: "Mario + Rabbit Kingdom", genre: "Turn-based", yearOfRelease: "2017", consoles: ["Nintendo Switch"], addedBy: "Blue Box", id: listOfGames.count + 1))
        listOfGames.append(Game(name: "Assaasins Creed: Origins", genre: "Action-Adventure", yearOfRelease: "2017", consoles: ["Xbox One","Playstation 4"], addedBy: "Blue Box", id: listOfGames.count + 1))
        listOfGames.append(Game(name: "FIFA 18", genre: "Sports", yearOfRelease: "2017", consoles: ["Xbox One","Playstation 4","Xbox 360","Playstaion 3","Nintendo Switch"], addedBy: "Blue Box", id: listOfGames.count + 1))
        listOfGames.append(Game(name: "Call of Duty: WWII", genre: "First-Person Shooter", yearOfRelease: "2017", consoles: ["Xbox One","Playstation 4"], addedBy: "Blue Box", id: listOfGames.count + 1))
        
    }
    
    func gameList(place: String) {
        
        var sortedList = place == "out" ? listOfGames.filter { $0.out == true } : place == "in" ? listOfGames.filter { $0.out == false } : listOfGames
        
        currentGames = sortedList
        var sortedComplete = [String]()
        var out = [String]()
        var count = [String]()
        addSpace(lines: 10)
        
        if sortedList.isEmpty {
            if gameSorting == "out" {
                print(evenMiddle(text: ["There are no games avaliable to be checked out"]))
            } else if  gameSorting == "in" {
                print(evenMiddle(text: ["There are no games checked out"]))
            } else {
                print(evenMiddle(text: ["There are no games"]))
            }
            
        } else {
            
            for i in 0...sortedList.count - 1 {
                sortedComplete.append("\(i + 1)) " + (gameSorting == "genre" ? "(\(sortedList[i].genre)) " : gameSorting == "year" ?  "(\(sortedList[i].year)) " : "") + (sortedList[i].dueDate.timeIntervalSinceNow < Date().timeIntervalSinceNow ? "(LATE) " : "") + sortedList[i].name)
                out.append(sortedComplete[i])
                count.append(repeatedPrint(length: out.last!.count + 3, by: "Ξ"))
                
                if (i + 1) % 3 == 0 || i == sortedList.count - 1 {
                    print(evenMiddle(text: out))
                    out.removeAll()
                    print(evenMiddle(text: count))
                    count.removeAll()
                    addSpace(lines: 2)
                }
            }
        }
        addSpace(lines: 30 - sortedList.count)
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
                    listOfGames = listOfGames.sorted {$0.year < $1.year}
                case 3:
                    gameSorting = "genre"
                    listOfGames = listOfGames.sorted {$0.genre < $1.genre}
                default:
                    gameSorting = "name"
                    listOfGames = listOfGames.sorted {$0.name < $1.name}
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

    func addGame() {

        var responses = [String]()
        var consoles = [String]()
        let questions = ["What is your name?","What is the name of the game?", "What genre is the game?", "What year was the game made?", "What console(s) support the game?"]

        for i in 0...questions.count - 1 {
            print("")
            print(evenMiddle(text: [questions[i]]))

            addSpace(lines: 2)

            responses.append(readLine()!)
            
            if i == 4 {
                consoles.append(responses[i])
                repeat{
                    print(evenMiddle(text: ["Any other Consoles? (if not, enter 'no')"]))
                    print("")
                    consoles.append(readLine()!)
                } while !consoles.last!.lowercased().contains("no")
                consoles.removeLast()
            }
        }

        listOfGames.append(Game(name: responses[1], genre: responses[2], yearOfRelease: responses[3], consoles: consoles, addedBy: responses[0], id: listOfGames.count + 1))

        print("Thanks for adding \(listOfGames.last!.name)")

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
            if (1...listOfGames.count).contains(place) {
                print(evenMiddle(text: ["Are you sure you want to remove '\(listOfGames[place - 1].name)' from the list of games?"]))
                
                if readLine()!.lowercased().contains("y") {

                    print((evenMiddle(text: [listOfGames[place - 1].name + "has been remove, Would you like to remove something else? (Yes/No)"])) )
                    listOfGames.remove(at: place - 1)

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
            if !(1...listOfGames.filter({$0.out == false}).count).contains(intCheck) {
                checkOutGame()
            }
            let place = listOfGames.map({$0.id}).index(of: currentGames[intCheck - 1].id)!
            if listOfGames[place].checkOut() {
            print(evenMiddle(text: ["Are you sure you want to check out \(listOfGames[place].name)??"]))
                
            if !readLine()!.lowercased().contains("y") {
                listOfGames[place].checkIn()
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
                listOfGames[place].checkedOutBy = name
                print(evenMiddle(text: ["'\(listOfGames[place].name)' is now checked out to \(name)"]))
                
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
        
        gameList(place: "out")
        if currentGames.isEmpty {
            mainMenu()
        }
        print(evenMiddle(text: ["Please enter the nunber of the game you with to check back in (enter '*' to resert the games)"]))
        print(evenMiddle(text: ["(Enter 'Esc' to go backto the main manu)"]))
        
        let checkSorting = readLine()!
        if checkSorting.contains("*") {
            sorting(place: "in")
        } else if checkSorting.lowercased().contains("esc") {
            mainMenu()
        }
        
        if let intCheck = Int(checkSorting) {
            if !(1...listOfGames.filter({$0.out == true}).count).contains(intCheck){
                checkInGame()
            }
            let place = listOfGames.map({$0.id}).index(of: currentGames[intCheck - 1].id)!
            if listOfGames[place].checkIn() {
                print(evenMiddle(text: ["Are you sure you want to check in \(listOfGames[place].name)??"]))
                
                if !readLine()!.lowercased().contains("y") {
                    listOfGames[place].checkOut()
                    print(evenMiddle(text: ["Do you want to check something else in?"]))
                    if readLine()!.lowercased().contains("y") {
                        checkInGame()
                    } else {
                        mainMenu()
                    }
                }
                print(evenMiddle(text: ["'\(listOfGames[place].name)' is now checked back in"]))
                
                addSpace(lines: 2)
            } else {
                print(evenMiddle(text: ["That game cannot be checked in or does not exist"]))
                
            }
            print(evenMiddle(text: ["Would you like to check in another game?"]))
            if !readLine()!.lowercased().contains("y") {
                addSpace(lines: 10)
                
                mainMenu()
            }
        }
        checkInGame()
    }

    init() {
    }
}

