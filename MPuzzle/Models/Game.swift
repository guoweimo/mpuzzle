//
//  Game.swift
//  MPuzzle
//
//  Created by Guowei Mo on 20/10/2018.
//  Copyright © 2018 Guowei Mo. All rights reserved.
//

import Foundation

class Game {
  
  let boxIndex: Int
  var states = [GameState]()
  var resultCount = 0
  var zHash = [Int: Int]()
  let zobHash = ZobristHash()
  
  init?(with pieces: [Piece]){
    let boxPieceIndex = pieces.firstIndex { $0.type == .box }
    guard let boxIndex = boxPieceIndex else {
      return nil
    }
    self.boxIndex = boxIndex
    let gameState = GameState()
    gameState.setUpInitialState(pieces)
    _ = hashNewStatePattern(gameState)
  }
  
  private func exitFound(at state: GameState) -> Bool {
    return (state.pieces[boxIndex].left == winingBoxLeft)
      && (state.pieces[boxIndex].top == winingBoxTop)
  }
  
  func resolveGame() -> Result? {
    var index = 0
    var solutions = [Solution]()
    
    while(index < states.count){
      let gameState = states[index]
      if exitFound(at: gameState) {
        resultCount += 1
        solutions.append(createSolution(from: gameState))
      } else {
        searchNewGameStates(from: gameState)
      }
      index += 1
    }
    var result = Result(isWon: resultCount > 0)
    result?.solutions = solutions
    return result
  }
  
  private func createSolution(from gameState: GameState) -> Solution {
    var history = [Board]()
    var state: GameState? = gameState
    while state != nil {
      history.insert(state!.board, at: 0)
      state = state?.parent
    }
    return Solution(totalSteps: gameState.step, history: history)
  }
  
  private func searchNewGameStates(from gameState: GameState) {
    for i in 0..<gameState.pieces.count {
      for j in 0..<directionsCount {
        trySearchPiecesNewState(from: gameState, pieceIndex: i, directionIndex: j)
      }
    }
  }
  
  private func trySearchPiecesNewState(from gameState: GameState,
                               pieceIndex: Int,
                               directionIndex: Int) {
    let newState = movePieceToNewState(from: gameState,
                                       pieceIndex: pieceIndex,
                                       directionIndex: directionIndex)
    if let newState = newState {
      if hashNewStatePattern(newState) {
        tryContinuouslyMovePiece(at: newState,
                                 pieceIndex: pieceIndex,
                                 directionIndex: directionIndex)
      }
    }
  }
  
  private func movePieceToNewState(from gameState: GameState,
                           pieceIndex: Int,
                           directionIndex: Int) -> GameState? {
    if gameState.canMovePiece(pieceIndex: pieceIndex, directionIndex: directionIndex) {
      let newState = GameState()
      
      //copy previous state (make sure deep copy)
      let currentBoard = gameState.board
      newState.board = currentBoard
      newState.pieces = gameState.pieces.map {
        Piece(type: $0.type, left: $0.left, top: $0.top, value: $0.value)
      }
      
      let piece = newState.pieces[pieceIndex]
      let direction = directions[directionIndex]
      
      newState.clearPosition(with: piece)
      
      piece.left = piece.left + direction.left
      piece.top = piece.top + direction.top
      
      newState.takePosition(piece)
      newState.step = gameState.step + 1
      
      newState.parent = gameState
      newState.move.pieceIndex = pieceIndex
      newState.move.directionIndex = directionIndex
      return newState
    }
    return nil
  }
  
  private func hashNewStatePattern(_ gameState: GameState) -> Bool {
    let l2rHash = zobHash.getHash(from: gameState)
    if zHash[l2rHash] == nil {
      zHash[l2rHash] = l2rHash
      let r2lHash = zobHash.getMirrorHash(from: gameState)
      zHash[r2lHash] = r2lHash
      states.append(gameState)
      return true
    }
    return false
  }
  
  private func tryContinuouslyMovePiece(at gameState: GameState,
                            pieceIndex: Int,
                            directionIndex: Int) {
    for d in 0..<directionsCount {
      if !isReverseDirection(directionIndex1: d, directionIndex2: directionIndex) {
        if let newState = movePieceToNewState(from: gameState,
                                              pieceIndex: pieceIndex,
                                              directionIndex: d) {
          if hashNewStatePattern(newState) {
            newState.step -= 1
            newState.parent = gameState.parent //remove intermediate move as continous move count as 1
          }
        }
      }
    }
  }
  
  private func isReverseDirection(directionIndex1: Int, directionIndex2: Int) -> Bool {
    return (directionIndex1 + 2) % directionsCount == directionIndex2
  }
}
