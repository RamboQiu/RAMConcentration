//
//  RAMConcentration.swift
//  RAMConcentration
//
//  Created by rambo on 2020/2/5.
//  Copyright © 2020 rambo. All rights reserved.
//

import Foundation

class Concentration {
//    var cards = Array<Card>() 数组的写法有点像java
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        // set(newValue) {
        // 不写newValue的参数形式，默认就是newValue参数
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if card match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                // either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)):")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            
//            let matchcard = card;//值赋值
//            cards.append(card)
//            cards.append(matchcard)
            
//            cards.append(card)
//            cards.append(card)//也是值赋值
            
            cards += [card, card] // 里面的数据也是值赋值，数组也是值赋值
        }
        
        // TODO: Shuffle the cards
        cards.sort { ( card1: Card, card2: Card) -> Bool in
            return arc4random_uniform(2) > 0
        }
    }
}
