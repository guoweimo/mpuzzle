//
//  GameConfig.swift
//  MPuzzle
//
//  Created by Guowei Mo on 21/10/2018.
//  Copyright © 2018 Guowei Mo. All rights reserved.
//

import Foundation

let gameRow = 5
let gameColumn = 4
let boardWidth = 6
let boardHeight = 7
let emptyCell = " "
let borderCellCode = "X"
let exitCellCode = "Z"
let boardPieceTypes = 5 //include empty
let directions = [ (left: 0, top: -1),
                   (left: 1, top: 0),
                   (left: 0, top: 1),
                   (left: -1, top: 0)] //(left, top)
let directionsCount = 4

let winingBoxLeft = 2
let winingBoxTop = 4
