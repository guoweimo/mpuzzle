//
//  MPuzzleTests.swift
//  MPuzzleTests
//
//  Created by Guowei Mo on 20/10/2018.
//  Copyright © 2018 Guowei Mo. All rights reserved.
//

import XCTest
@testable import MPuzzle

class GameStateTests: XCTestCase {

  let pieces: [Piece] = [
    Piece(type: .vBar, left: 1, top: 1, value: "a"),
    Piece(type: .vBar, left: 1, top: 3, value: "d"),
    Piece(type: .vBar, left: 4, top: 1, value: "c"),
    Piece(type: .vBar, left: 4, top: 3, value: "f"),
    Piece(type: .hBar, left: 2, top: 3, value: "e"),
    Piece(type: .box, left: 2, top: 1, value: "b"),
    Piece(type: .block, left: 2, top: 4, value: "g"),
    Piece(type: .block, left: 3, top: 4, value: "h"),
    Piece(type: .block, left: 1, top: 5, value: "i"),
    Piece(type: .block, left: 4, top: 5, value: "j"),
    ]

  func testCanCreateInitialGameState() {
    
    let gameState = GameState()
    gameState.setUpInitialState(pieces)
    
    XCTAssertEqual(gameState.board, [
      ["X", "X", "X", "X", "X", "X"],
      ["X", "a", "b", "b", "c", "X"],
      ["X", "a", "b", "b", "c", "X"],
      ["X", "d", "e", "e", "f", "X"],
      ["X", "d", "g", "h", "f", "X"],
      ["X", "i", " ", " ", "j", "X"],
      ["X", "X", "Z", "Z", "X", "X"],
    ])
//    print(gameState.board)
  }
  
}
