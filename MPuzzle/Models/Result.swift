//
//  Result.swift
//  MPuzzle
//
//  Created by Guowei Mo on 21/10/2018.
//  Copyright © 2018 Guowei Mo. All rights reserved.
//

import Foundation

struct Result {
  var isWon: Bool
  var solutions: [Solution] = []
  
  var optimalSolution: Solution? {
    return solutions.min { $0.totalSteps < $1.totalSteps }
  }
  
  var count: Int {
    return solutions.count
  }
  
  init?(isWon: Bool) {
    guard isWon else {
      return nil
    }
    self.isWon = isWon
  }
}

struct Solution {
  let totalSteps: Int
  var history: [Board]
  
  func printMoves() {
    history.enumerated().forEach { index, board in
      print("step: \(index)")
      board.forEach{ row in
        print(row)
      }
      print("\n")
    }
  }
}
