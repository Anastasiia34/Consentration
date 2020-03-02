//
//  ViewController.swift
//  Consentration
//
//  Created by Анастасия Стрекалова on 21.10.2019.
//  Copyright © 2019 Анастасия Стрекалова. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
         return (cardButtons.count + 1)/2
    }
    
    private lazy var randomTheme = Int(arc4random_uniform(UInt32(emojiChoices.count)))
    
//    private  lazy var clonedArray = emojiChoices[randomTheme]

    @IBAction func newGameButton(_ sender: Any) {
//        emojiChoices.remove(at: randomTheme)
//        emojiChoices += [clonedArray]
        emojiChoices = "🎃👻💀🦇🍭🍪🍫🍎"
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        randomTheme = Int(arc4random_uniform(UInt32(emojiChoices.count)))
        scoreLabel.text = "Score: 00"
        for index in cardButtons.indices {
            let button = cardButtons[index]
            var card = game.cards[index]
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            card.isFaceup = false
            card.isMatched = false
        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewfromModel()
        }
    }
    
    private func updateViewfromModel() {
        if cardButtons != nil {
            for index in cardButtons.indices {
                let score = game.score
                scoreLabel.text = "Score: \(score)"
                let flipCount = game.flips
                flipCountLabel.text = "Flips: \(flipCount)"
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFaceup {
                    button.setTitle(emoji(for: card), for: UIControl.State.normal)
                    button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                } else {
                    button.setTitle("", for: UIControl.State.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
                }
            }
        }
    }
    
//    private var emojiChoices =  [
//        ["🎃", "👻", "💀", "🦇", "🍭", "🍪", "🍫", "🍎"],
//        ["😀", "😆", "😇", "🤩", "😎", "🤓", "🥰", "🥳"],
//        ["🐶", "🐱", "🐭", "🐰", "🦊", "🐼", "🐮", "🦁"],
//        ["🧀", "🍣", "🍥", "🍟", "🍔", "🍿", "🍾", "🌯"],
//        ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉"],
//        ["🚗", "🚕", "🛴", "✈️", "🚂", "🏍", "🚎", "🚒"]
//    ]
    
    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewfromModel()
        }
    }
    
    private var emojiChoices = "🎃👻💀🦇🍭🍪🍫🍎"
    
    private var emoji = [Int:String]()
    
    private func emoji(for card: Card) -> String {
        
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
//            emoji[card.identifier] = emojiChoices[randomTheme].remove(at: emojiChoices[randomTheme].count.arc4random)
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card.identifier] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card.identifier] ?? "?"
    }

}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
