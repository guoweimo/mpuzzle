//
//  MoveAction.swift
//  MPuzzle
//
//  Created by Guowei Mo on 20/10/2018.
//  Copyright © 2018 Guowei Mo. All rights reserved.
//

import Foundation

class MoveAction {
  var directionIndex: Int
  var pieceIndex: Int
  init(pieceIndex: Int = 0, directionIndex: Int = 0){
    self.pieceIndex = pieceIndex
    self.directionIndex = directionIndex
  }
}
