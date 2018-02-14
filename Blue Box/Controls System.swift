//
//  Box System.swift
//  Blue Box
//
//  Created by Cristian Rodriguez on 2/9/18.
//  Copyright © 2018 Cristian Rodriguez. All rights reserved.
//

import Foundation

func wait(s: Double) {
    let now = Date()
    while Date.timeIntervalSinceReferenceDate - now.timeIntervalSinceReferenceDate < s {}
}
func clearScreen(lines: Int) {
    if lines > 1 {
        for _ in 1...lines {
            print("")
        }
    }
}
func lstring(l: [String]) -> String {
    var out = ""
    for i in l {
        out += i + (i == l.last ? "" : ", ")
    }
    return out
}

func box(Lenth: Int, by: String) -> String{
    var out = ""
    for _ in 1...Lenth {
        out += by
    }
    return out
}

func mid(t: [String]) -> String {
    var out = ""
    var then = 144 / (t.count + 1)
    for i in 0...t.count - 1 {
        let that = then - t[i].count / 2 - (i > 0 ? t[i - 1].count / 2 : 0)
        out += box(Lenth: that , by: " ")
        out += t[i]
        then = i == t.count - 1 ? (then - t[i].count + t[i].count / 2) : then
    }
    out += box(Lenth: then, by: " ")
    
    return out
}

func Launch() {
    print("""
        \(mid(t: ["ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ"]))
        \(mid(t: ["ΞΞ  Welcome To Blue Box ΞΞ"]))
        \(mid(t: ["ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ"]))
        
        """)
    let one = BoxSystem()
    one.defaultGames()
    one.mainMenu()
}

class BoxSystem {
    var checkedIn = [Game]()
    var checkedOut = [Game]()
    let formatter = DateFormatter()
    func mainMenu() {
        formatter.dateFormat = "dd-MM-yyyy - HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 39600)
        var holder = ""
        repeat {
            print("""
                \(mid(t: ["ΞΞΞ   Main Menu   ΞΞΞ"]))
                
                \(mid(t: ["[1] View Library"]))
                
                \(mid(t: ["[2] Add a Game ","[3] Remove a Game"]))
                
                \(mid(t: ["[4] Check out Game","[5] Check in Game"]))
                
                \(mid(t: ["[6] [Games Checked out]","[7] Exit"]))
                
                """)
            clearScreen(lines: 27)
            holder = readLine()!
        } while Int(holder) == nil
        clearScreen(lines: 10)
        switch Int(holder)! {
        case 1:
            inList()
        case 2:
            addGame()
        case 3:
            removeGame()
        case 4:
            gameOut()
        case 5:
            gameIn()
        case 6:
            outList()
        case 7:
            print(mid(t: ["ΞΞΞΞΞ     Goodbye     ΞΞΞΞΞ"]))
        default:
            mainMenu()
        }
    }
    func defaultGames() {
        checkedIn.append(Game(Name: "Super Mario Odyssey", Genre: "Platformer", Publisher: "Nintendo", YearOfRelease: 2017, Consoles: ["Nintendo Switch"]))
        checkedIn.append(Game(Name: "Forza Motorsport 7", Genre: "Racing", Publisher: "Microsoft Studios", YearOfRelease: 2017, Consoles: ["Xbox One"]))
        checkedIn.append(Game(Name: "Breath of the Wild", Genre: "Action-Adventure", Publisher: "Nintendo", YearOfRelease: 2017, Consoles: ["Nintendo Switch","Wii U"]))
        checkedIn.append(Game(Name: "Horizon Zero Dawn", Genre: "Action", Publisher: "Sonu", YearOfRelease: 2017, Consoles: ["Playstation 4"]))
        checkedIn.append(Game(Name: "Cuphead", Genre: "Run & Gun", Publisher: "Studio MDHR", YearOfRelease: 2017, Consoles: ["Xbox One"]))
        checkedIn.append(Game(Name: "Destiny 2", Genre: "First Person Shooter", Publisher: "Activision", YearOfRelease: 2017, Consoles: ["Xbox One","Playstation 4","PC"]))
        checkedIn.append(Game(Name: "Mario + Rabbit Kingdom Battle", Genre: "Turn-based", Publisher: "Ubisoft", YearOfRelease: 2017, Consoles: ["Nintendo Switch"]))
        checkedIn.append(Game(Name: "Assaasins Creed: Origins", Genre: "Action-Adventure", Publisher: "Ubisoft", YearOfRelease: 2017, Consoles: ["Xbox One","Playstation 4"]))
        checkedIn.append(Game(Name: "FIFA 18", Genre: "Sports", Publisher: "EA Sports", YearOfRelease: 2017, Consoles: ["Xbox One","Playstation 4","Xbox 360","Playstaion 3","Nintendo Switch"]))
        checkedIn.append(Game(Name: "Call of Duty: WWII", Genre: "First-Person Shooter", Publisher: "Activition", YearOfRelease: 2017, Consoles: ["Xbox One","Playstation 4"]))
    }
    func universalList(l: [Game]) {
        var out = [String]()
        var count = [String]()
        clearScreen(lines: 10)
        if l.isEmpty {
            print(mid(t: ["There Have no Games :("]))
        } else {
            for i in 0...l.count - 1 {
                out.append("\(i + 1)) " + l[i].name + (l[i].dueDate.timeIntervalSinceReferenceDate + 150 < Date().timeIntervalSinceReferenceDate ? "(LATE)" : "" ))
                count.append(box(Lenth: l[i].name.count + 7, by: "Ξ"))
                if (i + 1) % 3 == 0 || i == l.count - 1 {
                    print(mid(t: out))
                    out.removeAll()
                    print(mid(t: count))
                    count.removeAll()
                    clearScreen(lines: 2)
                }
            }
        }
        clearScreen(lines: 30 - l.count)
    }
    func inList() {
        clearScreen(lines: 20)
        universalList(l: checkedIn)
        print(mid(t: ["press Enter to continue"]))
        clearScreen(lines: 2)
        let _ = readLine()!
        clearScreen(lines: 20)
        mainMenu()
    }
    func addGame() {
        var responses = [""]
        var consoles = [""]
        let questions = ["What is the Name of the game??", "What Genre of the game??", "Who is the Publisher of the Game??", "What Year was the game made??", "What console support the game??"]
        for i in 0...questions.count - 1 {
            print("")
            print(questions[i])
            responses.append(readLine()!)
            if i == 4 {
                consoles.append(responses[i])
                repeat{
                    print("Any other Consoles??")
                    print("")
                    consoles.append(readLine()!)
                } while !consoles.last!.lowercased().contains("no")
                consoles.removeLast()
            }
        }
        checkedIn.append(Game(Name: responses[1], Genre: responses[2], Publisher: responses[3], YearOfRelease: Int(responses[4])!, Consoles: consoles))
        print("Thanks for adding \(checkedIn.last!.name)")
        wait(s: 1)
        mainMenu()
    }
    func removeGame() {
        var holder = ""
        repeat {
            universalList(l: checkedIn)
            print(mid(t: ["Please enter the number of the game you with to remove"]))
            clearScreen(lines: 3)
            holder = readLine()!
        } while Int(holder) == nil
        clearScreen(lines: 2)
        if (1...checkedIn.count).contains(Int(holder)!) {
            print(mid(t: ["Are you sure you sure you want to remove \(checkedIn[Int(holder)! - 1].name) from the Blue Box Video Game List"]))
            if readLine()!.lowercased().contains("yes") {
            print((mid(t: [checkedIn[Int(holder)! - 1].name + "has been remove, Would you like to remove something else??"])) )
                checkedIn.remove(at: Int(holder)! - 1)

            } else {
                removeGame()
            }
        } else {
            print("There is no Game with that number, Would you like to remove something else ")
        }
        if readLine()!.lowercased().contains("yes") {
            removeGame()
        } else {
            clearScreen(lines: 10)
            mainMenu()
        }
    }
    func gameOut() {
        var holder = ""
        repeat {
            universalList(l: checkedIn)
            print(mid(t: ["Which Game would you like to check out ??"]))
            clearScreen(lines: 2)
            holder = readLine()!
        } while Int(holder) == nil
        holder = String(Int(holder)! - 1)
        if (0...checkedIn.count).contains(Int(holder)!) {
            print(mid(t: ["Are you sure you want to check out (\(checkedIn[Int(holder)!].name))"]))
            if readLine()!.lowercased().contains("yes") {
                if !checkedIn[Int(holder)!].check(t: true) {
                    clearScreen(lines: 5)
                    print(mid(t: ["\(checkedIn[Int(holder)!].name) has been Checked out, it is due back before \(formatter.string(from: Date(timeIntervalSinceReferenceDate: checkedIn[Int(holder)! - 1].dueDate.timeIntervalSinceReferenceDate + 150 + 18000) ))"]))
                    checkedOut.append(checkedIn[Int(holder)!])
                    checkedIn.remove(at: Int(holder)!)
                clearScreen(lines: 2)
                } else {
                    print(mid(t: ["\(checkedIn[Int(holder)!].name) is already checked out"]))
                }
            } else {
            print(mid(t: ["Nothing has been removed, "]))
            }
        } else {
            gameOut()
        }
        mainMenu()
    }
    func gameIn() {
        var holder = ""
        if checkedOut.isEmpty {
            mainMenu()
        }
        repeat {
            universalList(l: checkedOut)
            print(mid(t: ["Which Game would you like to check in ??"]))
            clearScreen(lines: 2)
            holder = readLine()!
        } while Int(holder) == nil
        holder = String(Int(holder)! - 1)
        clearScreen(lines: 5)
            if (0...checkedOut.count).contains(Int(holder)!) {
                print(mid(t: ["\(checkedOut[Int(holder)!].name) has been checked back in :)"]))
                checkedOut[Int(holder)!].out = false
                checkedIn.insert(checkedOut[Int(holder)!], at: Int(holder)!)
                checkedOut.remove(at: Int(holder)!)
            } else {
                gameIn()
            }
        mainMenu()
    }
    func outList() {
        clearScreen(lines: 20)
        universalList(l: checkedOut)
        print(mid(t: ["press Enter to continue"]))
        clearScreen(lines: 2)
        let _ = readLine()!
        clearScreen(lines: 20)
        mainMenu()
    }
    init() {
    }
}

