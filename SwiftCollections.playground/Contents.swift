import UIKit

/** Array */
var array1: Array<Int> = Array<Int>()
var array2: [Int] = []
var array3 = array2

var threeInts = [Int](repeating: 3, count: 4)
var sixInts = threeInts + threeInts
var fiveInts = [1, 2, 3, 4, 5]

array1.count
fiveInts.count

if array2.isEmpty {
    print("array2 is Empty")
}

//fiveInts[2]
//fiveInts[5] // Crash

fiveInts[0...2] // ArraySlice
fiveInts[0..<2]

Array(fiveInts[0...2])

// 遍历1
for value in fiveInts {
    print(value)
}

// 遍历2
for (index, value) in fiveInts.enumerated() {
    print("\(index), \(value)")
}

// 遍历3
fiveInts.forEach { print($0) }

array1.append(1)
array1 += [2, 3, 4]

array1.insert(5, at: array1.endIndex)

array1.remove(at: 4)
array1

array1.removeLast()
array1
//array2.removeLast() // Crash

/** Array和NSArray */

func getBufferAddress<T>(of array: [T]) -> String {
    return array.withUnsafeBufferPointer{ buffer in
        return String(describing: buffer.baseAddress)
    }
}

var a = [1, 2, 3]
let copyA = a
getBufferAddress(of: a)
getBufferAddress(of: copyA)

a.append(4) // copy on write
copyA
getBufferAddress(of: a)
getBufferAddress(of: copyA)


let b = NSMutableArray(array: [1, 2, 3])
let copyB: NSArray = b

let deepCopyB = b.copy() as! NSArray

b.insert(0, at: 0)
copyB
deepCopyB


a.forEach { print("a:\($0)") }
for value in a {
    print("value:\(value)")
}
for (index, value) in a.enumerated() {
    print("index:\(index), value:\(value)")
}

// 查找元素位置
let index = a.index { $0 == 3 }
index
// 筛选所有偶数
let filer = a.filter { $0 % 2 == 0 }
filer

a.first
a.last
type(of: a.first)

a.removeLast() // 数组为空Crash
a
a.popLast() // 数组为空返回nil
a

/// 使用closure参数化对数组元素操作
var fibonacci = [0, 1, 4, 2, 3, 5]
let constSquares = fibonacci.map { $0 * $0 }
constSquares

extension Array {
    func myMap<T>(_ transform: (Element) -> T) -> [T] {
        var tmp: [T] = []
        tmp.reserveCapacity(count)
        
        for value in self {
            tmp.append(transform(value))
        }
        return tmp
    }
}

let constSquares1 = fibonacci.myMap { $0 * $0}
constSquares1

fibonacci.min()
fibonacci.max()
fibonacci.filter { $0 % 2 == 0 }

print(fibonacci.elementsEqual([0, 1, 1], by: { $0 == $1 }))
print(fibonacci.starts(with: [1, 2, 2], by: { $0 < $1 }))

fibonacci.sort()
fibonacci
fibonacci.sorted(by: >)
fibonacci

let pivot = fibonacci.partition(by: { $0 < 1 } )
pivot
fibonacci[0 ..< pivot]
fibonacci[pivot ..< fibonacci.endIndex]

fibonacci.reduce(0, +)
fibonacci

extension Array {
    func accumulate<T>(_ initial: T, _ nextSum: (T, Element) -> T) -> [T] {
        var sum = initial
        
        return map { next in
            sum = nextSum(sum, next)
            return sum
        }
    }
}

fibonacci.accumulate(0, +)


/// Filter / Reduce / FlatMap的实现和扩展
extension Array {
    func myFilter(_ predicate: (Element) -> Bool) -> [Element] {
        var tmp: [Element] = []
        
        for value in self where predicate(value) {
            tmp.append(value)
        }
        return tmp
    }
}
let arr = fibonacci.myFilter { $0 % 2 == 0 }
arr

extension Array {
    func reject(_ predicate: (Element) -> Bool) -> [Element] {
        return filter { !predicate($0) }
    }
}
let arr1 = fibonacci.reject { $0 % 2 == 0 }
arr1

let result = fibonacci.filter { $0 % 2 == 0 }.count > 0
result

let result1 = fibonacci.contains { $0 % 2 == 0 }
result1

extension Array {
    func allMatch(_ predicate: (Element) -> Bool) -> Bool {
        return !contains { !predicate($0) }
    }
}
let evens = [2, 4, 6, 8]
let isMatch = evens.allMatch { $0 % 2 == 0 }
isMatch


let animals = ["🐱", "🐶", "🐰", "🐼"]
let ids = [1, 2, 3, 4]
animals.map { animal in
    return ids.map { id in (animal, id)}
}

animals.flatMap { animal in
    return ids.map { id in (animal, id) }
}

extension Array {
    func myFlatMap<T>(_ transform: (Element) -> [T] ) -> [T] {
        var tmp: [T] = []
        for value in self {
            tmp.append(contentsOf: transform(value))
        }
        
        return tmp
    }
}
animals.myFlatMap { animal in
    return ids.map { id in (animal, id) }
}

/// Dictionary
enum RecordType {
    case bool(Bool)
    case number(Int)
    case text(String)
}

let record11: [String: RecordType] = [
    "uid": .number(11),
    "exp": .number(100),
    "favourite": .bool(true),
    "title": .text("Dictionary basics")
]

record11["uid"]
record11["favourite"]
record11["title"]
record11["invalid"]

type(of: record11["favourite"])

record11.count
record11.isEmpty
record11.keys
record11.values

for key in record11.keys {
    print(key)
}
record11.keys.forEach { print($0) }

var record10 = record11
record10["favourite"] = .bool(false)
record11["favourite"]

record10.updateValue(.bool(true), forKey: "favourite")

for (k, v) in record10 {
    
    print("\(k): \(v)::\(type(of: v))")
}
record10.forEach { print("\($0): \($1)")}

for key in record10.keys.sorted() {
    print("\(key): \(String(describing: record10[key]))")
}


let defaultRecord: [String: RecordType] = [
    "uid": .number(0),
    "exp": .number(100),
    "favourite": .bool(false),
    "title": .text("")
]

var template = defaultRecord
var record11Patch: [String: RecordType] = [
    "uid": .number(11),
    "title": .text("Common dictionry extensions")
]

extension Dictionary {
    mutating func merge<S: Sequence>(_ sequence: S)
        where S.Iterator.Element == (key: Key, value: Value) {
            sequence.forEach { self[$0] = $1 }
    }
}

template.merge(record11Patch)

let record10Patch: [(key: String, value: RecordType)] = [
    (key: "uid", value: .number(10)),
    (key: "title", value: .text("Common dictionary extensions"))
]
var template1 = defaultRecord
template1.merge(record10Patch)


extension Dictionary {
    init<S: Sequence>(_ sequence: S)
        where S.Iterator.Element == (key: Key, value: Value) {
        
            self = [:]
            self.merge(sequence)
    }
}
let record12 = Dictionary(record11Patch)


record11.map { $1 }

extension Dictionary {
    func mapValue<T>(_ transform: (Value) -> T) -> [Key: T] {
        return Dictionary<Key, T>(map { (k, v) in
            return (k, transform(v))
        })
    }
}

let newRecord11 = record11.mapValue { record -> String in
    switch record {
    case .text(let title):
        return title
    case .number(let exp):
        return String(exp)
    case .bool(let favourite):
        return String(favourite)
    }
}
newRecord11


/// 为自定义类型实现Hashable Key
struct Account {
    var alias: String
    var type: Int
    var createdAt: Date
    
    let INT_BIT = (Int)(CHAR_BIT) * MemoryLayout<Int>.size
    
    // 按位旋转
    func bitwiseRotate(value: Int, bits: Int) -> Int {
        return (((value) << bits) | ((value) >> (INT_BIT - bits)))
    }
}
let account11 = Account(alias: "11", type: 1, createdAt: Date())

extension Account: Hashable {
    var hashValue: Int {
        return bitwiseRotate(value: alias.hashValue, bits: 10) ^ type.hashValue ^ createdAt.hashValue
    }
}

//extension Account: Equatable {
//    static func == (lhs: Account, rhs: Account) -> Bool {
//        return lhs.alias == rhs.alias && lhs.type == rhs.type && lhs.createdAt == rhs.createdAt
//    }
//}

let data: [Account: Int] = [account11: 1000]


/// Set
var vowel: Set<Character> = ["a", "e", "i", "o", "u"]

vowel.count
vowel.isEmpty
vowel.contains("a")
vowel.remove("a")
vowel.insert("a")
//vowel.removeAll()

for character in vowel {
    print(character)
}

vowel.forEach { print($0) }

for character in vowel.sorted() {
    print(character)
}


var setA: Set = [1, 2, 3, 4, 5, 6]
var setB: Set = [4, 5, 6, 7, 8, 9]

let interSectAB: Set = setA.intersection(setB)
let symmetricDiffAB: Set = setA.symmetricDifference(setB)
let unionAB: Set = setA.union(setB)
let aSubstractB: Set = setA.subtracting(setB)

setA.formIntersection(setB)
setA

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var result: Set<Iterator.Element> = []
        
        return filter {
            if result.contains($0) {
                return false
            }
            else {
                result.insert($0)
                return true
            }
        }
    }
}

[1, 1, 2, 3, 4, 4, 6].unique()

// 一连串正整数
let oneToSix: IndexSet = [1, 2, 3, 4, 5, 6]
// String
let hw = "Hello world!"
// CharacterSet
let numbers = CharacterSet(charactersIn: "123456789")
print(numbers)
let letters = CharacterSet.letters
print(letters)
let members = CharacterSet(charactersIn: "eod")

hw.rangeOfCharacter(from: members)
hw.rangeOfCharacter(from: letters)

//for i in 1.0 ... 5.0 {
//    print(i)
//}

for i in stride(from: 1.0, to: 5.0, by: 1.0) {
    print(i)
}

for i in stride(from: 1.0, through: 5.0, by: 1.0) {
    print(i)
}
