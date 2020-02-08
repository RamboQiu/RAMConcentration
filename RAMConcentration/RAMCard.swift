//
//  RAMCard.swift
//  RAMConcentration
//
//  Created by rambo on 2020/2/5.
//  Copyright © 2020 rambo. All rights reserved.
//

import Foundation
/**
 struct和class比较
 struct不能继承
 struct值传递，代表每一次赋值都是copy，class是引用传递
**/

struct Card: Hashable {
    var hashValue: Int {
        return identifier
    }
    
    
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        // Card.identifierFactory
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
