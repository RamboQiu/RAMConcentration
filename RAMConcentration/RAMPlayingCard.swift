//
//  RAMPlayingCard.swift
//  RAMConcentration
//
//  Created by rambo on 2020/2/10.
//  Copyright © 2020 rambo. All rights reserved.
//

import Foundation

struct PlayingCard: CustomStringConvertible {
    var description: String {
        return "\(rank)\(suit)"
    }
    
    var suit: Suit
    var rank: Rank
    
    enum Suit: String, CustomStringConvertible {
        var description: String {
            switch self {
                case .spades: return "♠️"
                case .hearts: return "♥️"
                case .diamonds: return "♣️"
                case .clubs: return "♦️"
            }
        }
        case spades = "♠️"
        case hearts = "♥️"
        case diamonds = "♣️"
        case clubs = "♦️"
        
        static var all = [Suit.spades, .hearts, .diamonds, .clubs]
    }
    
//    enum Rank {
//        case ace
//        case two
//        case three
//        `
//        `
//        `
//        case jake
//        case queen
//        case king
//    }
//
//    enum Rank {
//        case ace
//        case face(String)
//        case numeric(Int)
//
//        var order: Int {
//            switch self {
//                case .ace: return 1
//                case .numeric(let pips): return pips
//                case .face(let kind):
//                    if kind == "J" {
//                        return 11
//                    } else if kind == "Q" {
//                        return 12
//                    } else {
//                        return 13
//                    }
//                default: return 0
//            }
//        }
//    }
    enum Rank {
//        var description: String {
//            return "\(self)"
//        }
        case ace
        case face(String)
        case numeric(Int)

        var order: Int {
            switch self {
                case .ace: return 1
                case .numeric(let pips): return pips
                case .face(let kind) where kind == "J": return 11
                case .face(let kind) where kind == "Q": return 11
                case .face(let kind) where kind == "K": return 11
                default: return 0
            }
        }
        static var all: [Rank] {
            //        var allRanks: [Rank] = [.ace]
            var allRanks = [Rank.ace]
            for pips in 2...10 {
                allRanks.append(Rank.numeric(pips))
            }
            //        allRanks += [Rank.face("J"),Rank.face("Q"),Rank.face("K")]
            allRanks += [Rank.face("J"),.face("Q"),.face("K")]
            return allRanks
        }
    }
    
}
