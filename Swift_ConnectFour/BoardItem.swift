//
//  BoardItems.swift
//  Swift_ConnectFour
//
//  Created by IceCream on 3/18/24.
//

import Foundation
import UIKit

enum ItemColor {
    case Red
    case Yellow
    case White
}
struct BoardItem {
    var indexPath : IndexPath!
    var color : ItemColor
    
    func isRed() -> Bool {
        return color == ItemColor.Red
    }
    
    func isYellow() -> Bool {
        return color == ItemColor.Yellow
    }
    
    func isWhite() -> Bool {
        return color == ItemColor.White
    }
    
    func displayColor() -> UIColor {
        switch(color) {
        case ItemColor.Red:
            return .red
        case ItemColor.Yellow:
            return .yellow
        default:
            return .white
        }
    }
}
