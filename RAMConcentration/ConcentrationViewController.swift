//
//  ViewController.swift
//  RAMConcentration
//
//  Created by rambo on 2020/2/5.
//  Copyright © 2020 rambo. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
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
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
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
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    @IBOutlet private var cardButtons: [UIButton]!
    
//    private var emojiChoices: [String] = ["🤡","👺","👻","🎃","🤖","💩","👽","👾","☠️","🤠"]
    private var emojiChoices = "🤡👺👻🎃🤖💩👽👾☠️🤠"
    
    var deck = PlayingCardDeck()
    
    @IBOutlet weak var playingCardView: PlayingCardView! {
        didSet {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
            swipe.direction = [.left, .right]
            playingCardView.addGestureRecognizer(swipe)
            
            let pich = UIPinchGestureRecognizer(target: playingCardView, action: #selector(PlayingCardView.adjustFaceCardScale(byHandlingGestureRecognizedBy:)))
            playingCardView.addGestureRecognizer(pich)
        }
    }
    
    @IBAction func flipCard(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            playingCardView.isFaceUp = !playingCardView.isFaceUp
        default:
            break;
        }
    }
    @objc func nextCard() {
        if let card = deck.draw() {
            playingCardView.rank = card.rank.order
            playingCardView.suit = card.suit.rawValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        
        for _ in 1...10 {
            if let card = deck.draw() {
                print("\(card)")
            }
        }
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
        if cardButtons != nil {
            //        for index in 0..<cardButtons.count {
            for index in cardButtons.indices {
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp {
                    button.setTitle(emoji(for: card), for: .normal)
                    button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                } else {
                    button.setTitle("", for: UIControl.State.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
                }
            }
        }
    }
    
    
    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String {
//        let chosenEmoji = emoji[card.identifier]
        if emoji[card] == nil , emojiChoices.count > 0 {
//            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            let randomStringIndex: String.Index = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        
        // ??前后没有空格会报错
        return emoji[card] ?? "?"
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

extension CGFloat {
    var arc4random: CGFloat {
        get {
            let tmp = self * 10000.0
            if self > 0 {
                return CGFloat(arc4random_uniform(UInt32(tmp))) / 10000.0
            } else if self < 0 {
               return -CGFloat(arc4random_uniform(UInt32(abs(tmp)))) / 10000.0
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


//闭包的演变过程

//1.
//func changeSign(operand: Double) -> Double { return -operand }
//
//var operation: (Double) -> Double
//operation = changeSign
//let result = operation(4.0)
//
//2.
//var operation: (Double) -> Double
//operation = (operand: Double) -> Double { return -operand }
//let result = operation(4.0)
//
//3.
//var operation: (Double) -> Double
//operation = { (operand: Double) -> Double in return -operand }
//let result = operation(4.0)
//
//4.
//var operation: (Double) -> Double
//operation = { (operand) in -operand }
//let result = operation(4.0)
//
//5. 
//var operation: (Double) -> Double
//operation = { -$0 }
//let result = operation(4.0)
//
//let primes = [2.0, 3.0, 5.0, 7.0, 11.0]
//let negativePrimes = primes.map({ -$0 }) // [-2.0, -3.0, -5.0, -7.0, -11.0]
//let negativePrimes2 = primes.map { -$0 } // [-2.0, -3.0, -5.0, -7.0, -11.0]
