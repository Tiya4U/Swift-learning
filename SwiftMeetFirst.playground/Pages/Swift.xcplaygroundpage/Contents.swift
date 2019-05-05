import UIKit

/** 变量和常量 */
/// Type Inference
var str = "Hello, playground"

var hours = 24

var PI = 3.14

var swiftIsFun = true

var me = ("Mars", 11, "11@bili.io")
me.0
me.1

hours = 12
PI = 3.14159

let miniutes = 30
let fireIsHot = true

/// Type annotation
var x: Int = 1
var s: String = "s"

/** 整数和浮点数 */
Int.min
Int.max

Int64.min
Int64.max

// Number literal
let fifteenInDecimal = 15       // 10进制
let fifteenInHex = 0xF          // 16进制
let fifteenInOctal = 0o17       // 8进制
let fifteenInBinary = 0b1111    // 2进制

let million = 1_000_000


var oneThirdInFloat: Float = 1/3
var oneThirdInDouble: Double = 1/3

var PI2 = 0.314e1
PI2 = 314e-2


var three = 3
type(of: three)

var zeroPointForteen = 0.14
type(of: zeroPointForteen)

PI2 = 3 + 0.14
type(of: PI2)

PI2 = Double(three) + zeroPointForteen


/** 使用Tuple打包数据 */
let success = (200, "HTTP OK")
let fileNotFound = (404, "File not found")

let me2 = (name: "Mars", no: 11, email: "11@aaa.io")

success.0
success.1

fileNotFound.0
fileNotFound.1

me2.name
me2.no
me2.email

var (successCode, successMessage) = success
print(successCode)
print(successMessage)

let (_, errorMessage) = fileNotFound
print(errorMessage)

var redirect: (Int, String) = (302, "temporary redirect")

let tuple11 = (1, 1)
let tuple12 = (1, 2)
tuple11 < tuple12

/** 常用操作符 */
let a = 20
let b = 10
let mod = a % b

let mod2 = 8.truncatingRemainder(dividingBy: 2.5) // 浮点数取模

// opt != nil ? opt! : b
var userInput: String? = "A user input"
var value = userInput ?? "A default input" // 当userInput不为nil时，就使用变量自身，否则就使用??后面的默认值

// [begin, end]
for index in 1...5 {
    print(index)
}

// [begin, end)
for index in 1..<5 {
    print(index)
}

/** 代码注释"Markdown方言" */
//: # Heading 1

/*:
  * item1
  * item2
  * item3
 */

/// A **demo** function
func demo() {}

/**
  * item1
  * item2
  * item3
 */
func demo1() {}

/*:
 > # IMPORTANT: something important you want to metion:
 A general descripiton here.
 1. item1
 2. item2
 3. item3
 ---
 [More info - Access swift.com](https://swift.com)
 */

/**
 # IMPORTANT: something important you want to metion:
 A general descripiton here.
 1. item1
 2. item2
 3. item3
 ---
 [More info - Access swift.com](https://swift.com)
 */
func test() {}


/** String */
let cafe = "Caf\u{00e9}"
let cafee = "Caf\u{0065}\u{0301}"

cafe.count
cafee.count

cafe.utf8.count
cafee.utf8.count

cafe.utf16.count
cafee.utf16.count

cafe == cafee

let nsCafe = NSString(characters: [0x43, 0x61, 0x66, 0xe9], length: 4)
let nsCafee = NSString(characters: [0x43, 0x61, 0x66, 0x65, 0x0301], length: 5)
nsCafe.length
nsCafee.length
nsCafe == nsCafee

let result = nsCafe.compare(nsCafee as String)
result == ComparisonResult.orderedSame

let circleCafee = cafee + "\u{20dd}"
circleCafee.count

"👩".count
"👩‍👩‍👦‍👦".count
"👩\u{200D}👩\u{200D}👦\u{200D}👦" == "👩‍👩‍👦‍👦"

let flags = "🇨🇳🇺🇸"
flags.count


//extension String: Collection {
//
//}
var swift = "Swift is fun"
swift.dropFirst(9)

cafee.dropFirst(4)
cafee.dropLast(1)

cafee.unicodeScalars.forEach { print($0) }
cafee.utf8.forEach { print($0) }
cafee.utf16.forEach { print($0) }

cafee.unicodeScalars.dropLast(1)
cafee.utf8.dropLast(1)
cafee.utf16.dropLast(1)

//let index = cafee.index(cafee.startIndex, offsetBy: 3)
let index = cafee.index(cafee.startIndex, offsetBy: 100, limitedBy: cafee.endIndex)
//cafee[index]

extension String {
    subscript(index: Int) -> Character {
        guard let index = self.index(startIndex, offsetBy: index, limitedBy: endIndex) else {
            fatalError("String index out of range")
        }
        
        return self[index]
    }
}

cafee[3]

let beg = cafee.startIndex
let end = cafee.index(beg, offsetBy: 3)
cafee[beg ..< end]

cafee.prefix(3)

var mixStr = "Swift很有很趣"

for (index, value) in mixStr.enumerated() {
    print("\(index): \(value)")
}

if let index = mixStr.lastIndex(of: "很") {
    mixStr.insert(contentsOf: "5.0", at: index)
}

if let cnIndex = mixStr.firstIndex(of: "很") {
    mixStr.replaceSubrange(cnIndex ..< mixStr.endIndex, with: " is interesting!")
}

let strs = mixStr.split(separator: " ")

var i = 0
let singleChars = mixStr.split { _ in
    if i > 0 {
        i = 0
        return true
    }
    else {
        i += 1
        return false
    }
}
singleChars
