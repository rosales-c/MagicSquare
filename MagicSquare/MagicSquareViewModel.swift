//
//  MagicSquareViewModel.swift
//  MagicSquare
//
//  Created by Cinthya Drake on 2/14/21.
//

import Foundation


class MagicSquareViewModel: ObservableObject {
    // bridges between the model and the view
    
    // to interpret the model for the view
    // to communicate the user intent ot the model
    @Published var gameModel = MagicSquareModel()
    
    var _gameInProgress = false
    var _gameWinner = false
    
    func didTapCell(row: Int, column: Int) {
        gameModel.didChooseCell(rows: row, columns: column)
        if winner() {
            _gameWinner = true
        }
    }
    
    func winner() -> Bool {
        return gameModel.didYouWin()
    }
    
    func gameInProgress() -> Bool {
        return _gameInProgress
    }
    
    func didChooseShuffle(difficulty:Int) {
        gameModel.createGameFor()
        switch difficulty {
        case 1:
            gameModel.shuffleBoard(moves: 10)
        case 2:
            gameModel.shuffleBoard(moves: 40)
        default:
            gameModel.shuffleBoard(moves: 80)
        }
        _gameInProgress = true
    }
    
    func reset() {
        gameModel = MagicSquareModel()
        _gameInProgress = false
    }
    
    func cellAt(row: Int, column: Int) -> BoardCell {
        gameModel.gameBoard[row][column]
    }
}



