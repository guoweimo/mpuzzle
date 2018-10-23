//
//  PiecesType.swift
//  MPuzzle
//
//  Created by Guowei Mo on 20/10/2018.
//  Copyright © 2018 Guowei Mo. All rights reserved.
//

import Foundation

//types of different shapes of pieces
enum PieceType: Int {
  case block = 1 //1x1
  case hBar = 2 //2x1
  case vBar = 3 //1x2
  case box = 4 //2x2
}

//definition of a piece
class Piece {
  
  let type: PieceType
  var left: Int
  var top: Int
  var value: String
  
  init(type: PieceType, left: Int, top: Int, value: String) {
    self.type = type
    self.left = left
    self.top = top
    self.value = value
  }
}
