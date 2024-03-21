//
//  Turn.swift
//  Swift_ConnectFour
//
//  Created by IceCream on 3/18/24.
//

import Foundation
import UIKit

enum Turn {
    case Red
    case Yellow
}

var curTurn = Turn.Yellow // initialize the first player

func toggleTurn (turnImage: UIImageView) {
    if curTurn == Turn.Yellow {
        curTurn = Turn.Red
        turnImage.tintColor = .red
    }
    else {
        curTurn = Turn.Yellow
        turnImage.tintColor = .systemYellow
    }
}

func currentTurnItemColor() -> ItemColor {
    return curTurn == Turn.Yellow ? ItemColor.Yellow : ItemColor.Red
}

func currentTurnUIColor() -> UIColor {
    return curTurn == Turn.Yellow ? .systemYellow : .red
}

func currentTurnWinMessage() -> String {
    return curTurn == Turn.Yellow ? "Yellow Wins!" : "Red Wins!"
}
