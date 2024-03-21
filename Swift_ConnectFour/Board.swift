//
//  Board.swift
//  Swift_ConnectFour
//
//  Created by IceCream on 3/18/24.
//

import Foundation
import UIKit

let NUM_ROWS = 6
let NUM_COLS = 7
var board = [[BoardItem]]()

func resetBoard() {
    board.removeAll()
    for row in 0..<NUM_ROWS {
        var rowArr = [BoardItem]()
        for col in 0..<NUM_COLS {
            let indexPath = IndexPath.init(item: col, section: row)
            let item = BoardItem(indexPath: indexPath, color: ItemColor.White)
            rowArr.append(item)
        }
        board.append(rowArr)
    }
}
func getBoardItem(indexPath: IndexPath) -> BoardItem {
    return board[indexPath.section][indexPath.item]
}

func getLowestWhiteItem(col: Int) -> BoardItem? {
    for row in (0..<NUM_ROWS).reversed() {
        if board[row][col].isWhite() {
            return board[row][col]
        }
    }
    return nil
}

func updateBoard(item: BoardItem) {
    if let iP = item.indexPath {
        board[iP.section][iP.item] = item
    }
}

func isBoardFull() -> Bool {
    for row in board {
        for col in row {
            if col.isWhite() {
                return false
            }
        }
    }
    return true
}

func isVictory() -> Bool {
    return horizontalWin() || verticalWin() || diagonalWin()
}

func horizontalWin() -> Bool {
    for row in board {
        var consecutive = 0
        for col in row {
            if col.color == currentTurnItemColor() {
                consecutive += 1
                if consecutive >= 4 {return true}
            }
            else {consecutive = 0}
            
        }
    }
    return false
}

func verticalWin() -> Bool {
    for col in 0..<NUM_COLS {
        var consecutive = 0
        for row in 0..<NUM_ROWS {
            if board[row][col].color == currentTurnItemColor() {
                consecutive += 1
                if consecutive >= 4 {return true}
            }
            else {consecutive = 0}
            
        }
    }
    return false
}

func diagonalWin() -> Bool {
    for col in 0..<NUM_COLS {
        if checkDiagonal(col: col, moveUp: true, reverseRows: true) ||
            checkDiagonal(col: col, moveUp: true, reverseRows: false) ||
            checkDiagonal(col: col, moveUp: false, reverseRows: true) ||
            checkDiagonal(col: col, moveUp: false, reverseRows: false) {
            return true
        }
    }
    return false
}

func checkDiagonal (col: Int, moveUp: Bool, reverseRows: Bool) -> Bool {
    let rows = reverseRows ? Array(0..<NUM_ROWS).reversed() : Array(0..<NUM_ROWS)
    var consecutive = 0
    var movingCol = col
    
    for row in rows {
        if movingCol >= 0 && movingCol < NUM_COLS {
            if board[row][movingCol].color == currentTurnItemColor() {
                consecutive += 1
                if consecutive >= 4 {return true}
            }
            else {consecutive = 0}
            movingCol = moveUp ? movingCol + 1 : movingCol - 1
        }
        
    }
    return false
}
