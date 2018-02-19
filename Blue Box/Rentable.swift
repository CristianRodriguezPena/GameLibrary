//
//  File.swift
//  Blue Box
//
//  Created by Izaak Prats on 2/19/18.
//  Copyright © 2018 Cristian Rodriguez. All rights reserved.
//

import Foundation

protocol Rentable {
    var checkedOut: Date? { get set }
    var isCheckedOut: Bool { get }
    var due: Date? { get }
    var late: Bool? { get }
}

enum RentableError: Error {
    case alreadyCheckedOut
    case notCheckedOut
}
