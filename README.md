# RAMConcentration
[swift官方学习资料](https://developer.apple.com/cn/swift/resources/)

[斯坦福swift课程学习](https://itunes.apple.com/us/course/developing-ios-10-apps-with-swift/id1198467120)

主要记录下和OC的差异的地方

# 1. Introduction to iOS 11, Xcode9 and Swift 4

1. Struct 和 Class的区别 

   1. struct是值类型，class是引用类型
   2. struct不能继承

2. swift引用类型只有闭包和类，其他Int String Array Dictionary 都是值类型

3. swift的KVO

   通过didSet 还有 willSet实现

   ```swift
   var flipCount = 0 {
     // set(newValue) {
     // 不写newValue的参数形式，默认就是newValue参数
     didSet {
       updateFlipCountLabel()
       print(\(newValue))// 默认参数
     }
   }
   ```

   

# 2. MVC

1. Swift的类型自动识别能力

   var game: Concentration = Concentration() swift赋值之后可以自动识别变量类型

   var a = 1 自动识别为Int

   oc写法 int a = 1,标准swift写法 var a: Int = 1,简写 var a = 1

   oc写法 NSDictionary<NSNumber, NSString> *emoji = NSDictionary.new;

   标准swift写法 var emoji: Dictionary<Int, String> = Dictionary<Int, String>()

   简写 var emoji = Dictionary<Int, String>()

   再简写 var emoji = \[Int:String\]()

2. swift的数组写法变化，包括字典

   ```swift
   //  var cards = Array<Card>() 数组的写法有点像java
     var cards = [Card]() // 原始写法如上
   // 	var emoji = Dictionary<Int: String>()
   	var emoji = [Card:String]()
   ```


3. 语法中的部分关键字需要空格

   单位运算符不能有空格 如 -1

   单位以上都需要

   ```swift
   // ??前后没有空格会报错
   	return emoji[card]?? "?"
   ```

4. 值赋值相关

   ```swift
   let card = Card()
               
   let matchcard = card;//值赋值
   cards.append(card)
   cards.append(matchcard)
   
   cards.append(card)
   cards.append(card)//也是值赋值
   
   cards += [card, card] // 里面的数据也是值赋值，数组也是值赋值
   ```

   

# 3. Swift Programming Language

1. 读属性

   这种是不会存储store到内存中的，每次取都去计算get

    ```swift
    // 只读属性，这种是不会存储store到内存中的，每次取都去计算get
    //    var numberOfPairsOfCards: Int {
    //        return (cardButtons.count + 1) / 2
    //    }
    var numberOfPairsOfCards: Int {
      get {
      	return (cardButtons.count + 1) / 2
      }
    }
    ```

2. 只读，只写

   ```swift
   private(set) var flipCount = 0 {
     didSet {
       updateFlipCountLabel()
     }
   }
   ```

3. Optional chaining ?.

   ```swift
   // optional chaining
   let x: String? = ...
   let y = x?.foo()?.bar?.z
   
   // 底层实现
   switch x {
       case .none: y = nil
       case .some(let data1):
           switch data1.foo() {
               case .none: y = nil
               case .some(let data2): {
                   switch data2.bar {
                       case .none: y = nil
                       case .some(let data3): y = data3.z
                   }
               }
           }
   }
   ```

4. enum

   enum的发音是：e na m

# 4. More Swift

1. 闭包的演变过程，加深闭包理解 什么是闭包 理解闭包

   ```swift
   //闭包的演变过程
   
   1. 正常写法与使用
   func changeSign(operand: Double) -> Double { return -operand }
   
   var operation: (Double) -> Double
   operation = changeSign
   let result = operation(4.0)
   
   2.将changeSign往下移
   var operation: (Double) -> Double
   operation = (operand: Double) -> Double { return -operand }
   let result = operation(4.0)
   
   3.语法变化，加前{前移，并替换为in
   var operation: (Double) -> Double
   operation = { (operand: Double) -> Double in return -operand }
   let result = operation(4.0)
   
   4.swift自动识别参数类型，已经return关键字
   var operation: (Double) -> Double
   operation = { (operand) in -operand }
   let result = operation(4.0)
   
   5. 使用$省略参数
   var operation: (Double) -> Double
   operation = { -$0 }
   let result = operation(4.0)
   
   let primes = [2.0, 3.0, 5.0, 7.0, 11.0]
   let negativePrimes = primes.map({ -$0 }) // [-2.0, -3.0, -5.0, -7.0, -11.0]
   // 小括号都可以去掉了
   let negativePrimes2 = primes.map { -$0 } // [-2.0, -3.0, -5.0, -7.0, -11.0]
   ```

2. @objc

   任何协议里面有可选实现方法，则这个协议必须要是@objc

   @objc还有用在其他地方，[例如](https://www.jianshu.com/p/b651126b1b1d)

3. mutating

   Any functions that are expected to mutate the receiver should be marked mutating (unless you are going to restrict your protocol to class implementers only with class keyword)



# 5. Drawing

1. Thrown Errors

   ```swift
   func save() throws
   
   do {
   	try context.save()
   } catch let error {
   	throw
   }
   ```

2. Any & AnyObject

   Any 类似OC的id，AnyObject只用来修饰class

   将Any转化为类来使用，不然无法使用，使用as?

   ```swift
   let unknown: Any = ....// we can't send unknown a message because it's "typeless"
   if let foo = unknown as? MyType {
   	// foo is of type MyType in here
   	// if unknown was not of type MyType, then we'll never get here
   }
   ```

3. swift中，一个对象可以不继承自NSObject

4. enum中，如果枚举类型是String，则取值是key

   ```swift
   enum Suit: String {
     case spades // "spades"
     case hearts // "hearts" 
     case diamonds
     case clubs
   }
   ```

5. enum枚举例子

   ```swift
   enum Rank {
     case ace
     case two
     case three
     `
     `
     `
     case jake
     case queen
     case king
   }
   
   enum Rank {
     case ace
     case face(String)
     case numeric(Int)
   
     var order: Int {
       switch self {
         case .ace: return 1
         case .numeric(let pips): return pips
         case .face(let kind):
         if kind == "J" {
           return 11
         } else if kind == "Q" {
           return 12
         } else {
           return 13
         }
         default: return 0
       }
     }
   }
   
   enum Rank {
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
   }
   ```

   

# 6. Multitouch

1. 使用context在drawRect中画圆

   ```swift
   if let context = UIGraphicsGetCurrentContext() {
     context.addArc(center: CGPoint(x: bounds.midX, y: bounds.midY), radius: 100, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
     context.setLineWidth(5.0)
     UIColor.green.setFill()
     UIColor.red.setStroke()
     context.strokePath()
     context.fillPath()
   }
   ```

   画出的圆，中间没有fill红色的原因：

   用strokePath的时候实际上是it consumes the path, it uses up the path, so when we do the fillPath on the next line, there's no path。

   所以想出效果应该用UIBezierPath

2. storyboard的代码显示设置

   ```swift
   @IBDesignable // 设置这个，可以build到storyboard中，除了image，image需要单独设置
   class PlayingCardView: UIView {
     @IBInspectalbe
     var rank: Int = 12 // 这个会变成storyboard的inspector中
     
     
     UIImage(named: rankString+suit, in: Bundle(for: self.classForCoder), compatibleWith: traitCollection) // 这样image就能在interface中查看了
   }
   ```

3. selector还是oc的，使用有技巧

   使用#selector 并且方法的前面需要加@objc 代表这个是一个oc的runtime方法

   ```swift
   @IBOutlet weak var playingCardView: PlayingCardView! {
     didSet {
       let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
       swipe.direction = [.left, .right]
       playingCardView.addGestureRecognizer(swipe)
     }
   }
   @objc func nextCard() {
     if let card = deck.draw() {
       playingCardView.rank = card.rank.order
       playingCardView.suit = card.suit.rawValue
     }
   }
   ```

   