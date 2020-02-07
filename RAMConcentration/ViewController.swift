//
//  ViewController.swift
//  RAMConcentration
//
//  Created by rambo on 2020/2/5.
//  Copyright © 2020 rambo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
//    var game: Concentration = Concentration() swift赋值之后可以自动识别变量类型
//    var a = 1 自动识别为Int
//    oc写法 int a = 1,标准swift写法 var a: Int = 1,简写 var a = 1
//    oc写法 NSDictionary<NSNumber, NSString> *emoji = NSDictionary.new;
//    标准swift写法 var emoji: Dictionary<Int, String> = Dictionary<Int, String>()
//    简写 var emoji = Dictionary<Int, String>()
//    再简写 var emoji = [Int:String]()
    
    private var game: Concentration! {
        didSet {
            updateViewFromModel()
        }
    }
    
    
    private(set) var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    // 只读属性，这种是不会存储store到内存中的，每次取都去计算get
    //    var numberOfPairsOfCards: Int {
    //        return (cardButtons.count + 1) / 2
    //    }
    var numberOfPairsOfCards: Int {
        get {
            return (cardButtons.count + 1) / 2
        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    
    private var emojiChoices: [String] = ["🤡","👺","👻","🎃","🤖","💩","👽","👾","☠️","🤠"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    private func updateViewFromModel() {
//        for index in 0..<cardButtons.count {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    private var emoji = [Int:String]()
    
    private func emoji(for card: Card) -> String {
//        let chosenEmoji = emoji[card.identifier]
        if emoji[card.identifier] == nil , emojiChoices.count > 0 {
//            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        
        // ??前后没有空格会报错
        return emoji[card.identifier] ?? "?"
    }


}

extension Int {
    var arc4random: Int {
        get {
            if self > 0 {
                return Int(arc4random_uniform(UInt32(self)))
            } else if self < 0 {
                return -Int(arc4random_uniform(UInt32(abs(self))))
            } else {
                return 0
            }
        }
    }
}

// optional chaining


//let x: String? = ...
//let y = x?.foo()?.bar?.z
//
//底层实现
//switch x {
//    case .none: y = nil
//    case .some(let data1):
//        switch data1.foo() {
//            case .none: y = nil
//            case .some(let data2): {
//                switch data2.bar {
//                    case .none: y = nil
//                    case .some(let data3): y = data3.z
//                }
//            }
//        }
//}

