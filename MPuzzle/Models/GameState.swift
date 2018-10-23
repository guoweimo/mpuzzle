//
//  Game.swift
//  MPuzzle
//
//  Created by Guowei Mo on 20/10/2018.
//  Copyright © 2018 Guowei Mo. All rights reserved.
//

import Foundation

typealias Direction = (left: Int, top: Int)
typealias Board = [[String]]

class GameState {
  
  var board = Board()
  var step: Int = 0
  let move = MoveAction()
  var pieces = [Piece]()
  var parent: GameState?
  
  init() {
    for i in 0..<boardHeight {
      board.append([])
      for j in 0..<boardWidth {
        board[i].append(emptyCell)
        if i == 0 || j == 0 || j == boardWidth - 1 {
          board[i][j] = borderCellCode
        }
        if i == boardHeight - 1 {
          if (j == winingBoxLeft || j == winingBoxLeft + 1) {
            board[i][j] = exitCellCode
          }  else {
            board[i][j] = borderCellCode
          }
        }
      }
    }
  }
  
  func setUpInitialState(_ pieces: [Piece]) {
    for i in 0..<pieces.count {
      tryAddPiece(pieces[i])
    }
  }
  
  
  func tryAddPiece(_ piece: Piece) {
    if isPositionFit(for: piece) {
      takePosition(piece)
      pieces.append(piece)
    }
  }
  
  func isPositionFit(for piece: Piece) -> Bool {
    var canFit = false
    
    let left = piece.left
    let top = piece.top
    switch(piece.type) {
    case .block:
      canFit = board[top][left] == emptyCell
    case .vBar:
      canFit = board[top][left] == emptyCell
        && board[top + 1][left] == emptyCell
    case .hBar:
      canFit = board[top][left] == emptyCell
        && board[top][left + 1] == emptyCell
    case .box:
      canFit = board[top][left] == emptyCell
        && board[top][left + 1] == emptyCell
        && board[top + 1][left] == emptyCell
        && board[top + 1][left + 1] == emptyCell
    }
    return canFit
  }
  
  func clearPosition(with piece: Piece) {
    let left = piece.left
    let top = piece.top
    switch(piece.type) {
    case .block:
      board[top][left] = emptyCell
    case .vBar:
      board[top][left] = emptyCell
      board[top + 1][left] = emptyCell
    case .hBar:
      board[top][left] = emptyCell
      board[top][left + 1] = emptyCell
    case .box:
      board[top][left] = emptyCell
      board[top][left + 1] = emptyCell
      board[top + 1][left] = emptyCell
      board[top + 1][left + 1] = emptyCell
    }
  }
  
  func canMovePiece(pieceIndex: Int, directionIndex: Int) -> Bool {
    
    var canMove = false
    let piece = pieces[pieceIndex]
    let direction = directions[directionIndex]
    let left = piece.left
    let top = piece.top

    switch(piece.type) {
    case .block:
      canMove = (board[top + direction.top][left + direction.left] == emptyCell)
    case .vBar:
      let v1 = board[top + direction.top][left + direction.left]
      let v2 = board[top + direction.top + 1][left + direction.left]
      canMove = (v1 == emptyCell || v1 == piece.value)
        && (v2 == emptyCell || v2 == piece.value)
    case .hBar:
      let v1 = board[top + direction.top][left + direction.left]
      let v2 = board[top + direction.top][left + direction.left + 1]
      canMove = (v1 == emptyCell || v1 == piece.value)
        && (v2 == emptyCell || v2 == piece.value)
    case .box:
      let v1 = board[top + direction.top][left + direction.left]
      let v2 = board[top + direction.top][left + direction.left + 1]
      let v3 = board[top + direction.top + 1][left + direction.left]
      let v4 = board[top + direction.top + 1][left + direction.left + 1]
      canMove = (v1 == emptyCell || v1 == piece.value)
        && (v2 == emptyCell || v2 == piece.value)
        && (v3 == emptyCell || v3 == piece.value)
        && (v4 == emptyCell || v4 == piece.value)
    }
    return canMove
  }
  
  func takePosition(_ piece: Piece) {
    let left = piece.left
    let top = piece.top
    let value = piece.value
    switch(piece.type) {
    case .block:
      board[top][left] = value
    case .vBar:
      board[top][left] = value
      board[top + 1][left] = value
    case .hBar:
      board[top][left] = value
      board[top][left + 1] = value
    case .box:
      board[top][left] = value
      board[top][left + 1] = value
      board[top + 1][left] = value
      board[top + 1][left + 1] = value
    }
  }  
}
