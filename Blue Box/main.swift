//
//  main.swift
//  Blue Box
//
//  Created by Cristian Rodriguez on 2/9/18.
//  Copyright © 2018 Cristian Rodriguez. All rights reserved.
//

import Foundation

let system = BoxSystem()
system.launch()

//36

let streets = ["Adams", "Bryant", "Channing", "Douglas", "Evarts"]
let streetsSlice = streets[2 ..< streets.endIndex]
print(streetsSlice)
