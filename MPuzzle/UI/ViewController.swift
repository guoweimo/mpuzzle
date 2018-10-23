//
//  ViewController.swift
//  MPuzzle
//
//  Created by Guowei Mo on 20/10/2018.
//  Copyright © 2018 Guowei Mo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var boardView: UIStackView!
  @IBOutlet weak var successLabel: UILabel!
  @IBOutlet weak var stepLabel: UILabel!
  
  @IBOutlet weak var actionButton: UIButton!
  var game: Game?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpGameView(hdPieces)
  }
  
  
  func setUpGameView(_ pieces: [Piece]) {
    game = Game(with: hdPieces)
    if let gameState = game?.states.first {
      updateBoardView(with: gameState.board)
    }
    successLabel.isHidden = true
    actionButton.isEnabled = true
    updateAcionTitle("Solve")
    stepLabel.text = "step: 0"
  }
  
  private func updateBoardView(with board: Board) {
    boardView.arrangedSubviews.enumerated().forEach { row in
      (row.element as? UIStackView)?.arrangedSubviews.enumerated().forEach {
        view in
        view.element.backgroundColor = labelColorMaps[board[row.offset][view.offset]]
      }
    }
  }
  
  @IBAction func solveButtonDidTap(_ button: UIButton) {
    button.isEnabled = false
    if button.currentTitle == "Solve" {
      updateAcionTitle("Solving...")
      DispatchQueue.global().async {
        if let result = self.game?.resolveGame(),
          let history = result.optimalSolution?.history {
            self.displayMoves(for: history)
        } else {
          DispatchQueue.main.async {
            self.displayFailedView()
          }
        }
      }
    } else if button.currentTitle == "Reset" {
      setUpGameView(hdPieces)
    }
  }
  
  private func displayMoves(for boards: [Board]) {
    boards.enumerated().forEach { index, board in
      DispatchQueue.main.async {
        self.updateBoardView(with: board)
        self.stepLabel.text = "step: \(index)"
        if board == boards.last {
          self.actionButton.isEnabled = true
          self.successLabel.isHidden = false
          self.successLabel.text = "Success!"
          self.updateAcionTitle("Reset")
        }
      }
      sleep(1)
    }
  }
  
  private func displayFailedView() {
    successLabel.isHidden = false
    successLabel.text = "Failed."
  }
  
  func updateAcionTitle(_ title: String) {
    actionButton.setTitle(title, for: .normal)
  }
}

