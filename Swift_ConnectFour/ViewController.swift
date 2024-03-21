//
//  ViewController.swift
//  Swift_ConnectFour
//
//  Created by IceCream on 3/18/24.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var redScores = 0
    var yellowScores = 0
    

    @IBOutlet weak var turnImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        resetBoard()
        setCellWidthHeight()
    }
    func setCellWidthHeight() {
        let w = collectionView.frame.size.width / 9
        let h = collectionView.frame.size.height / 6
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: w, height: h)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return board.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell_id", for: indexPath) as! BoardCell
        let item = getBoardItem(indexPath: indexPath)
        cell.image.tintColor = item.displayColor()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return board[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let col = indexPath.item
        if var item = getLowestWhiteItem(col: col) {
            if let cell = collectionView.cellForItem(at: item.indexPath) as? BoardCell {
                cell.image.tintColor = currentTurnUIColor()
                item.color = currentTurnItemColor()
                updateBoard(item: item)
                
                if isVictory() {
                    if curTurn == Turn.Yellow {
                        yellowScores += 1
                    }
                    else {
                        redScores += 1
                    }
                    showResult(title: currentTurnWinMessage())
                }
                if isBoardFull() {
                    showResult(title: "Draw")
                }
                
                toggleTurn(turnImage: turnImage)
            }
        }
            
    }
    
    func showResult(title: String) {
        let message = "\nRed: " + String(redScores) + "\n\nYellow: " + String(yellowScores)
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Reset", style: .default, handler: {
            [self] (_) in
            resetBoard()
            self.resetCells()
        }))
        self.present(alertController, animated: true)
    }
    
    func resetCells() {
        for cell in collectionView.visibleCells as! [BoardCell] {
            cell.image.tintColor = .white
        }
    }
}

