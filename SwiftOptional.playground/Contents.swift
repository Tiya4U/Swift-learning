import UIKit

let number: Int? = 1

if number != nil {
    print(number!)
}

if let number = number {
    print(number)
}

if let number = number, number % 2 != 0 {
    print(number)
}

let numbers = [1, 2, 3, 4, 5, 6]
var iterator = numbers.makeIterator()
while let element = iterator.next() {
    print(element)
}

// 由于变量i在每次循环都是一个新绑定的结果，因此，每一次添加到fnArray中的closure捕获到的变量都是不同的对象
var fnArray: [() -> ()] = []
for i in 0...2 {
    fnArray.append({ print(i) })
}
fnArray[0]()
fnArray[1]()
fnArray[2]()

func arrayProcess(array: [Int]) {
    guard let first = array.first else {
        return
    }
    
    print(first)
}

// fatalError也是一个返回Never的函数
func toDo(item: String?) -> Never {
    guard let item = item else {
        fatalError("Nothing to do")
    }
    fatalError("Implement \(item) later")
}


/// Chaining and Nil coalescing
var swift: String? = "Swift"
var SWIFT: String!

if let swift = swift {
    SWIFT = swift.uppercased()
}
else {
    fatalError("Cannot uppercase a nil")
}

let SWIFT2 = swift?.uppercased().lowercased()

let numbers2 = ["fibo6": [0, 1, 1, 2, 3, 5]]
numbers2["fibo6"]?[0]

var userInput: String? = nil
let username = userInput != nil ? userInput! : "Mars"

// nil coalescing操作符??
let username2 = userInput ?? "Mars"

let a: String? = nil
let b: String? = nil
let c: String? = "C"

let theFirstNonNilString = a ?? b ?? c

if let theFirstNonNilString = a ?? b ?? c {
    print(theFirstNonNilString)
}

let one: Int?? = .some(nil)
let two: Int? = 2
let three: Int? = 3

one ?? two ?? three
(one ?? two) ?? three

let stringOnes: [String] = ["1", "One", "Two"]

let intOnes = stringOnes.map { Int($0) }
intOnes.forEach { print($0) }

var i = intOnes.makeIterator()
while let i = i.next() {
    print(i)
}
// Swift对嵌套在optional内部的nil进行了识别，当遇到这类情况时，可以直接把nil提取出来，表示结果为nil

// 统计所有的非nil值
for case let one? in intOnes {
    print(one)
}

// 统计所有的nil值
for case nil in intOnes {
    print("got a nil value")
}
// 如果Swift不能对optional中嵌套的nil进行自动处理，上面的for循环是无法正常工作的。


let swift3: String? = "swift"
//let SWIFT3: String? = nil
//if let swift = swift3 {
//    SWIFT3 = swift.uppercased()
//}
// 当SWIFT是常量
// 对于optional类型来说，如果它的值非nil，map就会把unwrapping的结果传递给它的closure参数，否则，就直接返回nil
let SWIFT3 = swift3.map { $0.uppercased() }
type(of: SWIFT3)

extension Optional {
    func myMap<T>(_ transform: (Wrapped) -> T) -> T? { // Wrapped，这是Optional类型的泛型参数
        if let value = self {
            return transform(value)
        }
        
        return nil
    }
}
let SWIFT4 = swift.myMap { $0.uppercased() }


let numbers3 = [1, 2, 3, 4]
let sum = numbers3.reduce(0, +)

extension Array {
    func reduce(_ nextResult: (Element, Element) -> Element) -> Element? {
//        guard let first = first else {
//            return nil
//        }
//        return dropFirst().reduce(first, nextResult)
        return first.map { // 如果first为nil，map就返回nil，否则，就从Array中的第一个元素开始reduce
            dropFirst().reduce($0, nextResult)
        }
    }
}

let sum2 = numbers3.reduce(+)

/// Optional flatMap 处理双层嵌套optional类型的变换
let stringOne: String? = "1"
let ooo = stringOne.map { Int($0) }
type(of: ooo)

let oo = stringOne.flatMap { Int($0) }
type(of: oo)

if let stringOne = stringOne, let o = Int(stringOne) {
    print(o)
    type(of: o)
}

// 实际上，Optional.flatMap就完全是基于if let来实现的：
extension Optional {
    func myFlatMap<T>(_ transform: (Wrapped) -> T?) -> T? {
        if let value = self, let mapped = transform(value) {
            return mapped
        }
        
        return nil
    }
}

let mm = stringOne.myFlatMap { Int($0) }
type(of: mm)


let ints = ["1", "2", "3", "4", "five"]
ints.map { Int($0) }

var all = 0
for case let int? in ints.map({ Int($0) }) {
    all += int
}
all

extension Sequence {
    func myFlatMap<T>(_ transform: (Iterator.Element) -> T?) -> [T] {
        return self.map(transform).filter { $0 != nil }.map { $0! }
    }
}
let all2 = ints.myFlatMap { Int($0) }.reduce(0, +)
all2

let all3 = ints.compactMap { Int($0) }.reduce(0, +)
all3


let episodes = [
    "The fail of sentinal values": 100,
    "Common optional operation": 150,
    "Nested optionals": 180,
    "Map and flatMap": 220,
]

episodes.keys.filter { episodes[$0]! > 100 }.sorted()
episodes

// 语义更好的表达方式
episodes.filter { (_, duration) in duration > 100 }
    .map { (title, _) in title }
    .sorted()
episodes


/// 调试optional小技巧
var record = ["name": "11"]
//record["type"] !! "Do not have a key named type"
// 中序操作符
infix operator !!
func !!<T>(optional: T?, errorMsg: @autoclosure () -> String) -> T {
    if let value = optional {
        return value
    }
    fatalError(errorMsg)
}
//record["type"] !! "No this key!!!"

infix operator !?
//func !?<T: ExpressibleByStringLiteral>( // ExpressibleByStringLiteral这个protocol约束了类型T必须是一个String
//    optional: T?,
//    errorMsg: @autoclosure () -> String) -> T {
//    assert(optional != nil, errorMsg()) // assert仅在debug mode生效
//    return optional ?? "" // 而在release mode，则会得到一个空字符串
//}

//record["type"] !? "Do not have a key named type"

//func !?<T: ExpressibleByStringLiteral>(
//    optional: T?,
//    nilDefault: @autoclosure () -> (errorMsg: String, value: T)) -> T {
//    assert(optional != nil, nilDefault().errorMsg) // assert仅在debug mode生效
//    return optional ?? nilDefault().value // 而在release mode，则会得到一个默认值
//}
//record["type"] !? ("Do not have a key named type", "Free")

func !?(optional: Void?, errorMsg: @autoclosure () -> String) {
    assert(optional != nil, errorMsg())
}

//record["type"]?.write(" account") !? "No Key"
