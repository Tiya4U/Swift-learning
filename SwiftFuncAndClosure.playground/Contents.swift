import UIKit


func mul1(_ m: Int, of n: Int = 1) {
    print(m * n)
}
mul1(2)

func mul2(_ numbers: Int ...) {
    let arrayMul = numbers.reduce(1, *)
    print("mul2: \(arrayMul)")
}
mul2(1, 2, 3, 4)

func mul3(result: inout Int, _ numbers: Int ...) {
    result = numbers.reduce(1, *)
    print("mul3: \(result)")
}
var result = 0
mul3(result: &result, 2, 3, 4, 5, 6, 7)
result

func mul4(_ numbers: Int ...) -> Int {
    return numbers.reduce(1, *)
}
let result4 = mul4(2, 3, 4, 5, 6, 7)


func mul(m: Int, of n: Int) -> Int {
    return m * n
}

let fnMul = mul
fnMul(2, 3)

func div(a: Int, b: Int) -> Int {
    return a / b
}
var fnDiv: (_ a: Int, _ b: Int) -> Int = div
fnDiv(2, 3)

func calc<T>(_ first: T, _ second: T, _ fn:(T, T) -> T) -> T {
    return fn(first, second)
}
calc(2, 3, mul)
calc(4, 2, div)

func mul5(_ a: Int) -> (Int) -> Int {
    func innerMul(_ b: Int) -> Int {
        return a * b
    }
    return innerMul
}
let mul5By = mul5(3)
mul5By(2)
mul5(3)(2)


func square(n: Int) -> Int {
    return n * n
}

let squareExpression = { (n: Int) -> Int in
    return n * n
}

square(n: 2)
squareExpression(2)

let numbers = [1, 2, 3, 4, 5]
numbers.map(square)
numbers.map(squareExpression)

numbers.map({ (n: Int) -> Int in
    return n * n
})

numbers.map({ n in return n * n })

numbers.map({ n in n * n })

numbers.map({ $0 * $0 })

numbers.map() { $0 * $0 }

numbers.map { $0 * $0 }

numbers.sorted(by: { $0 > $1 })

numbers.sorted(by: >)

(0...9).map { _ in arc4random() }

func makeCounter() -> () -> Int {
    var value = 0
    // makeCounter返回的函数，捕获了makeCounter的内部变量value
    return {
        value += 1
        
        return value
    }
}
// counter1、counter2就叫做closure
let counter1 = makeCounter()
let counter2 = makeCounter()

(0...2).forEach { _ in print(counter1()) }
(0...5).forEach { _ in print(counter2()) }

func makeCounter2() -> () -> Int {
    var value = 0
    // 函数也可以捕获变量
    func increment() -> Int {
        value += 1
        return value
    }
    return increment
}

print("///////////////")

extension Array where Element: Comparable {
    mutating func mergeSort(_ begin: Index, _ end: Index) {
        
        // 通过捕获局部变量共享资源
        var tmp: [Element] = []
        tmp.reserveCapacity(count)
        
        func merge(_ begin: Int, _ mid: Int, _ end: Int) {
            tmp.removeAll(keepingCapacity: true)

            var i = begin
            var j = mid
            print("mid:\(mid)")
            while i != mid && j != end {
                if self[i] < self[j] {
                    tmp.append(self[i])
                    print("i:\(i) j:\(j) \(self[i]) \(self[j]) tmp:\(tmp)")
                    i += 1
                }
                else {
                    tmp.append(self[j])
                    print("i:\(i) j:\(j) \(self[i]) \(self[j]) tmp:\(tmp)")
                    j += 1
                }
            }
            
            tmp.append(contentsOf: self[i ..< mid])
            tmp.append(contentsOf: self[j ..< end])
            
            replaceSubrange(begin..<end, with: tmp)
            print(self)
        }
        
        if (end - begin) > 1 {
            let mid = (begin + end) / 2
            mergeSort(begin, mid)
            mergeSort(mid, end)
            merge(begin, mid, end)
        }
        
    }
}

//extension Array where Element: Comparable {
//    private mutating func merge(_ begin: Index, _ mid: Index, _ end: Index) {
//        var tmp: [Element] = []
//
//        var i = begin
//        var j = mid
//        print("mid:\(mid)")
//        while i != mid && j != end {
//            if self[i] < self[j] {
//                tmp.append(self[i])
//                print("i:\(i) j:\(j) \(self[i]) \(self[j]) tmp:\(tmp)")
//                i += 1
//            }
//            else {
//                tmp.append(self[j])
//                print("i:\(i) j:\(j) \(self[i]) \(self[j]) tmp:\(tmp)")
//                j += 1
//            }
//        }
//
//        tmp.append(contentsOf: self[i ..< mid])
//        tmp.append(contentsOf: self[j ..< end])
//
//        replaceSubrange(begin..<end, with: tmp)
//    }
//}
var numbers2 = [1, 9, 6, 2, 8]
numbers2.mergeSort(numbers.startIndex, numbers.endIndex)
numbers2

// OC运行时特性进行排序
// Key-Value coding
// selector
final class Episode: NSObject {
    @objc var title: String
    @objc var type: String
    @objc var length: Int
    
    override var description: String {
        return title + "\t" + type + "\t" + String(length)
    }
    
    init(title: String, type: String, length: Int) {
        self.title = title
        self.type = type
        self.length = length
    }
}

let episodes = [
    Episode(title: "title 1", type: "Free", length: 520),
    Episode(title: "title 4", type: "Paid", length: 500),
    Episode(title: "title 2", type: "Free", length: 330),
    Episode(title: "title 5", type: "Paid", length: 260),
    Episode(title: "title 3", type: "Free", length: 240),
    Episode(title: "title 6", type: "Paid", length: 390),
]

// key:要排序的属性 ascending:是否按升序排序 selector:进行比较的方法
let typeDescriptor = NSSortDescriptor(key: #keyPath(Episode.type), ascending: true, selector: #selector(NSString.localizedCompare(_:)))

let descriptors = [typeDescriptor]

let sortedEpisodes = (episodes as NSArray).sortedArray(using: descriptors)

sortedEpisodes.forEach { print($0 as! Episode) }

let lengthDescriptor = NSSortDescriptor(key: #keyPath(Episode.length), ascending: true)

let desctriptors2 = [typeDescriptor, lengthDescriptor]

let sortedEpisodes2 = (episodes as NSArray).sortedArray(using: desctriptors2)

sortedEpisodes2.forEach { print("\(type(of: $0)) " + ($0 as! Episode).description) }


// 通过类型系统模拟OC的运行时特性
typealias SortDescriptor<T> = (T, T) -> Bool
let stringDescriptor: SortDescriptor<String> = {
    $0.localizedCompare($1) == .orderedAscending
}
let lengthDescriptor2: SortDescriptor<Episode> = {
    $0.length < $1.length
}

// 为SortDescriptor创建一个工厂函数
// @escaping修饰用于获取Value以及排序的函数参数，
// 因为在返回的函数里，使用了key以及isAscending，这两个函数逃离了makeDescriptor作用域
// 作为参数的函数类型默认是不能逃离的，需要明确告知编译器这种情况
func makeDescriptor<Key, Value>(key: @escaping (Key) -> Value, _ isAscending: @escaping (Value, Value) -> Bool) -> SortDescriptor<Key> {
    
    return { isAscending(key($0), key($1)) }
}

let lengthDescriptor3: SortDescriptor<Episode> = makeDescriptor(key: { $0.length }, <)

let typeDescriptor2: SortDescriptor<Episode> = makeDescriptor(key: { $0.type }, { $0.localizedCompare($1) == .orderedAscending })

episodes.sorted(by: typeDescriptor2).forEach { print($0) }
episodes.sorted(by: lengthDescriptor3).forEach { print($0) }

// 合并多个排序条件
func combine<T>(rules: [SortDescriptor<T>]) -> SortDescriptor<T> {
    return { l, r in
        for rule in rules {
            if rule(l, r) {
                return true
            }
            
            if rule(r, l) {
                return false
            }
        }
        
        return false
    }
}

let mixDescriptor = combine(rules: [typeDescriptor2, lengthDescriptor3])

episodes.sorted(by: mixDescriptor).forEach { print($0) }


// 复杂排序中处理optional
let numbers3 = ["Five", "4", "3", "2", "1"]

func shift<T: Comparable>(_ compare: @escaping (T, T) -> Bool) -> (T?, T?) -> Bool {
    return { l, r in
        switch (l, r) {
        case (nil, nil):
            return false
        case (nil, _):
            return false
        case (_, nil):
            return true
        case let (l?, r?):
            return l < r
        default:
            fatalError()
        }
    }
}
let intDescriptor: SortDescriptor<String> = makeDescriptor(key: { Int($0) }, shift(<))
numbers3.sorted(by: intDescriptor).forEach { print($0) }

// 自定义组合排序规则的操作符

func |><T>(l: @escaping SortDescriptor<T>, r: @escaping SortDescriptor<T>) -> SortDescriptor<T> {
    
    return {
        if l($0, $1) {
            return true
        }
        
        if l($1, $0) {
            return false
        }
        
        if r($0, $1) {
            return true
        }
        
        return false
    }
}

infix operator |>: LogicalDisjunctionPrecedence

episodes.sorted(by: typeDescriptor2 |> lengthDescriptor3).forEach { print($0) }


/// delegate
// class
protocol FinishAlertViewDelegate: class {
    func buttonPressed(at index:Int)
}

class FinishAlertView {
    var buttons: [String] = ["Cancel", "The next"]
    weak var delegate: FinishAlertViewDelegate?
    
    func goToTheNext() {
        delegate?.buttonPressed(at: 1)
    }
}

class EpisodeViewController: FinishAlertViewDelegate {
    var episodeAlert: FinishAlertView!
    var count = 0
    
    init() {
        self.episodeAlert = FinishAlertView()
        self.episodeAlert.delegate = self
    }
    
    func buttonPressed(at index: Int) {
        self.count += 1
        print("Go to the next episode...")
    }
}

let evc = EpisodeViewController()
evc.episodeAlert.goToTheNext()
evc.episodeAlert.goToTheNext()
evc.episodeAlert.goToTheNext()
evc.episodeAlert.goToTheNext()
evc.count

//----------------------------------
// struct
protocol Finish2AlertViewDelegate {
    mutating func buttonPressed(at Index: Int)
}

class Finish2AlertView {
    var buttons: [String] = ["Cancel", "The next"]
    var delegate: Finish2AlertViewDelegate?
    
    func goToTheNext() {
        delegate?.buttonPressed(at: 1)
    }
}

struct PressCounter: Finish2AlertViewDelegate {
    var count = 0
    
    mutating func buttonPressed(at Index: Int) {
        print("Press Count:\(count)")
        self.count += 1
    }
}

class Episode2ViewController {
    var episodeAlert: Finish2AlertView!
    var counter: PressCounter!
    
    init() {
        self.episodeAlert = Finish2AlertView()
        self.counter = PressCounter()
        self.episodeAlert.delegate = self.counter
    }
}

let evc2 = Episode2ViewController()
evc2.episodeAlert.goToTheNext()
evc2.episodeAlert.goToTheNext()
evc2.episodeAlert.goToTheNext()
evc2.episodeAlert.goToTheNext()
evc2.episodeAlert.goToTheNext()

evc2.counter.count // Still 0
// 因为PressCounter是一个值类型，当我们执行self.episodeAlert.delegate = self.counter时，delegate实际上是self.counter的拷贝，它们引用的并不是同一个对象，因此调用goToTheNext()的时候，增加的只是self.episodeAlert.delegate，而不是self.counter
(evc2.episodeAlert.delegate as! PressCounter).count

// callback
class Finish3AlertView {
    var buttons: [String] = ["Cancel", "The next"]
    var buttonPressed: ((Int) -> Void)?
    
    func goToTheNext() {
        buttonPressed?(1)
    }
}

class Press3Counter {
    var count = 0
    
    func buttonPressed(at Index: Int) {
        self.count += 1
    }
    
}

class Episode3ViewController {
    let episodeAlert: Finish3AlertView!
    var counter: Press3Counter!
    
    init() {
        episodeAlert = Finish3AlertView()
        counter = Press3Counter()
        
//        episodeAlert.buttonPressed = { self.counter.buttonPressed(at: $0) }
        episodeAlert.buttonPressed = {[weak counter] index in
            counter?.buttonPressed(at: index)
        }
    }
}

let evc3 = Episode3ViewController()
evc3.episodeAlert.goToTheNext()
evc3.episodeAlert.goToTheNext()
evc3.episodeAlert.goToTheNext()
evc3.episodeAlert.goToTheNext()
evc3.episodeAlert.goToTheNext()

evc3.counter.count


/// inout参数
func incremental(_ i: inout Int) -> Int {
    i = i + 1
    return i
}
// 变量可以
var i = 1
incremental(&i)
i

// 变量-集合类型下标操作符可以
var numbers4 = [1, 2, 3]
incremental(&numbers4[0])

// 同时有get和set方法
struct Color {
    var r: Int
    var g: Int
    var b: Int
    
    var hex: Int {
        return r << 16 + g << 8 + b
    }
}
var red = Color(r: 254, g: 0, b: 0)
incremental(&red.r)
//incremental(&red.hex) // NO!

// 自定义操作符的inout参数在传递的时候不需要使用&
prefix func ++(i: inout Int) -> Int {
    i += 1
    return i
}
++i

func doubleIncrement(_ i: inout Int) {
    func increment() {
        i += 1
    }
    [0, 1].forEach { _ in increment() }
}
doubleIncrement(&i)
i

//func increment(_ i: inout Int) -> () -> Void {
//    return {
//        i += 1 // 不能通过内嵌函数，让inout参数逃离函数作用域
//    }
//}

// 可以把UnsafeMutablePointer<Int>理解为C语言中的Int *
func incrementByReference(_ pointer: UnsafeMutablePointer<Int>) {
    pointer.pointee += 1
}
incrementByReference(&i)
i

// 警惕一种情况，尽量不要让它们返回一个函数类型，否则，你的App就时刻面临崩溃的风险
//func incrementByRefrence(_ pointer: UnsafeMutablePointer<Int>) -> () -> Int {
//    return {
//        pointer.pointee += 1
//        return pointer.pointee
//    }
//}
//
//var boom: (() -> Int)?
//if true {
//    var j = 0
//
//    boom = incrementByRefrence(&j)
//
//}
//boom!()


/// 把参数自动转化为closure
func logicAnd(_ l: Bool, _ r: () -> Bool) -> Bool {
    print("logic1")
    guard l else {
        return false
    }
    return r()
}

if logicAnd(!numbers.isEmpty, { numbers[0] > 0 }) {
    print("logic run")
}

// @autoclosure修饰参数类型，自动把这个表达式变成一个closure
func logicAnd(_ l: Bool, _ r: @autoclosure () -> Bool) -> Bool {
    print("logic2")
    guard l else {
        return false
    }
    return r()
}

if logicAnd(!numbers.isEmpty, numbers[0] > 0) {
    print("logic2 run")
}
