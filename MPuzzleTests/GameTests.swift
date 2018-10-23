//
//  GameTests.swift
//  MPuzzleTests
//
//  Created by Guowei Mo on 20/10/2018.
//  Copyright © 2018 Guowei Mo. All rights reserved.
//

import XCTest
@testable import MPuzzle

class GameTests: XCTestCase {
  
  let pieces1: [Piece] = [
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
  
  let pieces2: [Piece] = [
    Piece(type: .block, left: 1, top: 1, value: "a"),
    Piece(type: .box, left: 2, top: 1, value: "b"),
    Piece(type: .block, left: 4, top: 1, value: "c"),
    Piece(type: .vBar, left: 1, top: 2, value: "d"),
    Piece(type: .hBar, left: 2, top: 3, value: "e"),
    Piece(type: .vBar, left: 4, top: 2, value: "f"),
    Piece(type: .vBar, left: 1, top: 4, value: "g"),
    Piece(type: .block, left: 2, top: 4, value: "h"),
    Piece(type: .block, left: 3, top: 4, value: "i"),
    Piece(type: .vBar, left: 4, top: 4, value: "j")
  ]
  
  func testInvalidGame() {
    var invalidPieces = pieces2
    invalidPieces.remove(at: 1) // remove box
    let game = Game(with: invalidPieces)
    XCTAssertNil(game, "game can not be created without a box piece")
  }
  
  func testGameSolution() {
    let game = Game(with: pieces1)
    let result = game?.resolveGame()
    
    XCTAssertEqual(result?.count, 4)
    
    XCTAssertEqual(result?.solutions.count, 4)

    let solutions = result?.solutions
    
    XCTAssertEqual(solutions?[0].totalSteps, 81)
    XCTAssertEqual(solutions?[1].totalSteps, 85)
    XCTAssertEqual(solutions?[2].totalSteps, 98)
    XCTAssertEqual(solutions?[3].totalSteps, 101)
    
    XCTAssertEqual(result?.optimalSolution?.totalSteps, 81)
    
    XCTAssertEqual(result?.optimalSolution?.history.last,
      [
        ["X", "X", "X", "X", "X", "X"],
        ["X", "a", "d", "c", "f", "X"],
        ["X", "a", "d", "c", "f", "X"],
        ["X", "g", "h", "e", "e", "X"],
        ["X", " ", "b", "b", "i", "X"],
        ["X", " ", "b", "b", "j", "X"],
        ["X", "X", "Z", "Z", "X", "X"],
      ]
    )
    //uncomment this to see the moves in each step
//    result?.optimalSolution?.printMoves()
  }
  
  func testGameSolution2() {
    let game = Game(with: pieces2)
    let result = game?.resolveGame()
    
    XCTAssertEqual(result?.count, 4)
    
    XCTAssertEqual(result?.solutions.count, 4)
    
    let solutions = result?.solutions
    
    XCTAssertEqual(solutions?[0].totalSteps, 74)
    XCTAssertEqual(solutions?[1].totalSteps, 80)
    XCTAssertEqual(solutions?[2].totalSteps, 94)
    XCTAssertEqual(solutions?[3].totalSteps, 97)
    
    XCTAssertEqual(result?.optimalSolution?.totalSteps, 74)
    
    XCTAssertEqual(result?.optimalSolution?.history.last,
                   [
                    ["X", "X", "X", "X", "X", "X"],
                    ["X", "g", "d", "j", "f", "X"],
                    ["X", "g", "d", "j", "f", "X"],
                    ["X", "a", "c", "e", "e", "X"],
                    ["X", " ", "b", "b", "h", "X"],
                    ["X", " ", "b", "b", "i", "X"],
                    ["X", "X", "Z", "Z", "X", "X"],
                    ]
    )
    //uncomment this to see the moves in each step
//    result?.optimalSolution?.printMoves()
  }

}
