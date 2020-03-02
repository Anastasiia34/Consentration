//
//  Concentration.swift
//  Consentration
//
//  Created by Анастасия Стрекалова on 29.10.2019.
//  Copyright © 2019 Анастасия Стрекалова. All rights reserved.
//

import Foundation

struct Concentration {
    private(set) var cards = [Card]()
    
    var score: Int
    
    var flips: Int
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceup }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceup = (index == newValue)
            }
        }
    }
    
    var previouslySeenCards = [Int]()
    
    mutating func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        flips += 1
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    if previouslySeenCards.contains(index){
                        score -= 1
                    }
                    if previouslySeenCards.contains(matchIndex){
                        score -= 1
                    }
                    previouslySeenCards += [index, matchIndex]
                }
                cards[index].isFaceup = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards.")
        for _ in  1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        score = 0
        
        flips = 0
        
        var emptyArray = [Card]()
        for _ in cards{
            let randomIndex = (cards.count - 1).arc4random
            emptyArray.append(cards[randomIndex])
            cards.remove(at: randomIndex)
        }
        cards = emptyArray
        
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
