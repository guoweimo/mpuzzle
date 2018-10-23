//
//  ZobristHash.swift
//  MPuzzle
//
//  Created by Guowei Mo on 20/10/2018.
//  Copyright © 2018 Guowei Mo. All rights reserved.
//

import Foundation

class ZobristHash {
  
  private(set) var hashCodes = [[[Int]]]()
  
  init() {
    for i in 0..<gameRow {
      hashCodes.append([[Int]]())
      for j in 0..<gameColumn {
        hashCodes[i].append([Int]())
        for _ in 0..<boardPieceTypes {
          let rand = Int.random(in: 1..<Int.max)
          hashCodes[i][j].append(rand)
        }
      }
    }
  }
  
  func getHash(from gameState: GameState) -> Int {
    var hash = 0
    let pieces = gameState.pieces
    for i in 1...gameRow {
      for j in 1...gameColumn {
        let piece = pieces.first { $0.value == gameState.board[i][j] }
        let type = piece == nil ? 0 : piece!.type.rawValue
        hash = hash ^ hashCodes[i - 1][j - 1][type]
      }
    }
    return hash
  }
  
  func getMirrorHash(from gameState: GameState) -> Int {
    var hash = 0
    let pieces = gameState.pieces
    for i in 1...gameRow {
      for j in 1...gameColumn {
        let piece = pieces.first { $0.value == gameState.board[i][j] }
        let type = piece == nil ? 0 : piece!.type.rawValue
        hash = hash ^ hashCodes[i - 1][gameColumn - j][type]
      }
    }
    return hash
  }
  
}
