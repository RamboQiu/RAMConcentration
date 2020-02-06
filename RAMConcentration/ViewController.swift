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
    
    var game: Concentration! {
        didSet {
            updateViewFromModel()
        }
    }
    
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    var emojiChoices: [String] = ["🤡","👺","👻","🎃","🤖","💩","👽","👾","☠️","🤠"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
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
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
//        let chosenEmoji = emoji[card.identifier]
        if emoji[card.identifier] == nil , emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        // ??前后没有空格会报错
        return emoji[card.identifier] ?? "?"
    }


}

