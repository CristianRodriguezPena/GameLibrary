//
//  StringManipulation.swift
//  Blue Box
//
//  Created by Cristian Rodriguez on 2/15/18.
//  Copyright © 2018 Cristian Rodriguez. All rights reserved.
//

import Foundation

var screenSize = 144 // 144 is the number of characters that fit in one line of the terminal when it is fullscreen, - 27 for each side bar in xcodes, and - 46 for the variable view next to the console

func addSpace(lines: Int) {
    if lines > 1 {
        for _ in 1...lines {
            print("")
        }
    }
}

func repeatedPrint(length: Int, by: String) -> String{
    var out = ""
    while out.count <= length {
        out += by
    }
    return out
}

//func evenMiddle(text: [String]) -> String {
//    var out = ""
//    let totalSpace = 144
//    var space = totalSpace / (text.count + 1) // 144 is the number of characters that fit in one line of the terminal when it is fullscreen, - 27 for each side bar in xcodes, and - 46 for the variable view
//    for i in 0...text.count - 1 {
//        var that = space - text[i].count / 2 - (i > 0 ? text[i - 1].count / 2 : 0)
//        out += repeatedPrint(length: that , by: " ")
//        out += text[i]
//        space = i == text.count - 1 ? (space - text[i].count + text[i].count / 2) : space
//    }
//    out += repeatedPrint(length: space, by: " ")
//    return out
//}

func evenMiddle(text: [String]) -> String {
    var editedText = text
    var space = screenSize - 1
    for taken in 0...editedText.count - 1 {
        editedText[taken] = String(Array(editedText[taken])[0 ..< (editedText[taken].count > screenSize / editedText.count ? screenSize / editedText.count - 1 : editedText[taken].count)])
        space -= editedText[taken].count
    }
    var out = repeatedPrint(length: space / (editedText.count + 1), by: " ")
    for thing in editedText {
        out = out + thing
        out = out + repeatedPrint(length: space / (editedText.count + 1), by: " ")
    }
    return out
}
