//
//  MagicSquareModel.swift
//  MagicSquare
//
//  Created by Cinthya Drake on 2/14/21.
//

import Foundation

struct MagicSquareModel {
    // the internal represenatation of the game will be stores in this file
    
    // include the logic for playing the game
    
    var gameBoard: [ [BoardCell] ] = []
    let numberOfRows: Int = 4
    let numberOfColumns: Int = 4
    var arrayOfCellInts: [ [Int] ] = []
    
    mutating func createGameFor() {
        
        for rowIdx in 0..<(numberOfRows) {
            gameBoard.append( [BoardCell]() )
            for _ in 0..<(numberOfColumns){
                gameBoard[rowIdx].append( BoardCell(cellType: CellType.numberCell(representing: 0)) )
            }
        }
        
        configureNumberCells(rows: numberOfRows, columns: numberOfColumns)
        configureBlankCells()
    }
    
    mutating func configureBlankCells() {
        gameBoard[3][3].cellType = CellType.blankCell
    }
    
    mutating func configureNumberCells(rows:Int, columns:Int) {
        for row in 0..<rows {
            var rowOfCellInts: [Int] = []
            for column in 0..<columns {
                if row == 0{
                    gameBoard[row][column].cellType = CellType.numberCell(representing: 1 + column )
                    rowOfCellInts.append(1 + column)
                } else if row == 1 {
                    gameBoard[row][column].cellType = CellType.numberCell(representing: 5 + column)
                    rowOfCellInts.append(5 + column)
                } else if row == 2 {
                    gameBoard[row][column].cellType = CellType.numberCell(representing: 9 + column)
                    rowOfCellInts.append(9 + column)
                } else if row == 3 {
                    gameBoard[row][column].cellType = CellType.numberCell(representing: 13 + column)
                    rowOfCellInts.append(13 + column)
                }
            }
            arrayOfCellInts.append(rowOfCellInts)
        }
    }
    
    
    mutating func shuffleBoard(moves:Int){
        var row = 3
        var column = 3
        var value = arrayOfCellInts[row][column]
        var srow = 0
        var scol = 0
        var sval = 0
        var lastmove = 0
        for _ in 0..<moves {
            var rand = Int.random(in: 1...4)
            
            while rand == 1 && column == 0{
                rand =  Int.random(in: 1...4)
            }
            
            while rand == 2 && row == 0{
                rand =  Int.random(in: 1...4)
            }
            
            while rand == 3 && column == 3{
                rand =  Int.random(in: 1...4)
            }
            
            while rand == 4 && row == 3{
                rand =  Int.random(in: 1...4)
            }
            
            
            if rand == 1 && lastmove == 3{
                rand = 2
            } else if rand == 2 && lastmove == 4{
                rand = 3
            } else if rand == 3 && lastmove == 1 {
                rand = 4
            }else if rand == 4 && lastmove == 2 {
                rand = 1
            }
            
            if rand == 1 && column != 0 {
                srow = row
                scol = column - 1
                sval = arrayOfCellInts[srow][scol]
                gameBoard[row][column].cellType = CellType.numberCell(representing: sval)
                gameBoard[srow][scol].cellType = CellType.blankCell
                arrayOfCellInts[row][column] = sval
                arrayOfCellInts[srow][scol] = value
                row = srow
                column = scol
                value = arrayOfCellInts[row][column]
                print("went left")
                lastmove = rand
            } else if rand == 2 && row != 0 {
                srow = row - 1
                scol = column
                sval = value - 4
                sval = arrayOfCellInts[srow][scol]
                gameBoard[row][column].cellType = CellType.numberCell(representing: sval)
                gameBoard[srow][scol].cellType = CellType.blankCell
                arrayOfCellInts[row][column] = sval
                arrayOfCellInts[srow][scol] = value
                row = srow
                column = scol
                value = arrayOfCellInts[row][column]
                print("went up")
                lastmove = rand
            } else if rand == 3 && column != 3 {
                srow = row
                scol = column + 1
                sval = value + 1
                sval = arrayOfCellInts[srow][scol]
                gameBoard[row][column].cellType = CellType.numberCell(representing: sval)
                gameBoard[srow][scol].cellType = CellType.blankCell
                arrayOfCellInts[row][column] = sval
                arrayOfCellInts[srow][scol] = value
                row = srow
                column = scol
                value = arrayOfCellInts[row][column]
                print("went right")
                lastmove = rand
            } else if rand == 4 && row != 3 {
                srow = row + 1
                scol = column
                sval = value + 4
                sval = arrayOfCellInts[srow][scol]
                gameBoard[row][column].cellType = CellType.numberCell(representing: sval)
                gameBoard[srow][scol].cellType = CellType.blankCell
                arrayOfCellInts[row][column] = sval
                arrayOfCellInts[srow][scol] = value
                row = srow
                column = scol
                value = arrayOfCellInts[row][column]
                print("went down")
                lastmove = rand
            }
        }
    }
    
    mutating func swapCells (blank: (row: Int, column: Int), num: (row: Int, column: Int)) {
        let value =  arrayOfCellInts[num.row][num.column]
        gameBoard[blank.row][blank.column].cellType = CellType.numberCell(representing: value)
        gameBoard[num.row][num.column].cellType = CellType.blankCell
        arrayOfCellInts[blank.row][blank.column] = value
        arrayOfCellInts[num.row][num.column] = 16
    }
    
    mutating func isNeighbor(row: Int, column: Int) -> (Bool, Int, Int) {
        if row != 3 && gameBoard[row + 1][column].cellType == CellType.blankCell{
            return (true , row + 1 , column)
        } else if column != 3 && gameBoard[row][column + 1].cellType == CellType.blankCell{
            return (true , row , column + 1)
        } else if row != 0 && gameBoard[row - 1][column].cellType == CellType.blankCell{
            return (true , row - 1 , column)
        } else if column != 0 && gameBoard[row][column - 1].cellType == CellType.blankCell{
            return (true , row , column - 1)
        } else {
            return (false, -1, -1)
        }
    }
    
    mutating func didChooseCell(rows: Int, columns: Int) {
        let hiNeighbor = isNeighbor(row: rows, column: columns)
        if hiNeighbor.0 {
            swapCells(blank: (hiNeighbor.1 , hiNeighbor.2), num: (rows, columns))
        } else{
            return
        }
    }
    
    func didYouWin() -> Bool {
        var count=1
        for row in 0..<4 {
            for col in 0..<4 {
                if arrayOfCellInts[row][col] != count {
                    return false
                }
                count = count + 1
            }
        }
        return true
    }
}

enum CellType: Comparable {
    case numberCell (representing: Int)
    case blankCell
}

struct BoardCell {
    var cellType: CellType
    var neighbor = false
}
