//
//  ZobristHashTests.swift
//  MPuzzleTests
//
//  Created by Guowei Mo on 20/10/2018.
//  Copyright © 2018 Guowei Mo. All rights reserved.
//

import XCTest
@testable import MPuzzle

class ZobristHashTests: XCTestCase {
  
  var pieces1: [Piece] = [
    Piece(type: .box, left: 1, top: 1, value: "a"),
    Piece(type: .vBar, left: 3, top: 1, value: "b"),
    Piece(type: .vBar, left: 4, top: 1, value: "c"),
    Piece(type: .vBar, left: 4, top: 3, value: "d"),
    Piece(type: .vBar, left: 1, top: 4, value: "e"),
    Piece(type: .hBar, left: 1, top: 3, value: "f"),
    Piece(type: .block, left: 3, top: 3, value: "g"),
    Piece(type: .block, left: 2, top: 4, value: "h"),
    Piece(type: .block, left: 2, top: 5, value: "i"),
    Piece(type: .block, left: 4, top: 5, value: "j"),
  ]
  
  var pieces2: [Piece] = [
    Piece(type: .box, left: 3, top: 1, value: "a"),
    Piece(type: .vBar, left: 2, top: 1, value: "b"),
    Piece(type: .vBar, left: 1, top: 1, value: "c"),
    Piece(type: .vBar, left: 1, top: 3, value: "d"),
    Piece(type: .vBar, left: 4, top: 4, value: "e"),
    Piece(type: .hBar, left: 3, top: 3, value: "f"),
    Piece(type: .block, left: 2, top: 3, value: "g"),
    Piece(type: .block, left: 3, top: 4, value: "h"),
    Piece(type: .block, left: 3, top: 5, value: "i"),
    Piece(type: .block, left: 1, top: 5, value: "j"),
  ]
  
  func testZobristHash() {
    let gameState1 = GameState()
    gameState1.setUpInitialState(pieces1)
    
    let gameState2 = GameState()
    gameState2.setUpInitialState(pieces2)
    
    let zHash = ZobristHash()
    
    XCTAssertEqual(zHash.getHash(from: gameState1), zHash.getMirrorHash(from: gameState2))
  }
}
