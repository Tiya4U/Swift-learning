import UIKit

var i = 0
while i < 10 {
    print(i)
    i += 1
}
print("-------------")
repeat {
    print(i)
    i -= 1
} while i > 0

// case 匹配的值 = 要检查的对象
let pt1 = (x: 0, y: 0)
if case (0, 0) = pt1 {
    print("@Origin")
}

switch pt1 {
case (0, 0):
    print("@Origin")
case (_, 0):
    print("on x axis")
case (0, _):
    print("on y axis")
case (-1...1, -1...1):
    print("inside 2x2 square")
default:
    break
}

let array1 = [1, 1, 2, 2, 2]
for case 2 in array1 {
    print("found two")
}

// 把匹配内容绑定到变量
switch pt1 {
case (let x, 0):
    print("(\(x), 0) is on x axis")
case (0, let y):
    print("(0, \(y)) is on y axis")
default:
    break
}

enum Direction {
    case north, south, east, west(addr: String)
}
let west = Direction.west(addr: "W")

if case .west = west {
    print(west)
}

if case .west(let direction) = west {
    print(direction)
}

let skills: [String?] = ["Swift", nil, "PHP", "JavaScript", nil]
for case let skill? in skills {
    print(skill)
}

let someValues: [Any] = [1, 1.0, "One"]
for value in someValues {
    switch value {
    case let v as Int:
        print("Integer \(v) \(type(of: v))")
    case let v as Double:
        print("Double \(v) \(type(of: v))")
    case is String:
        print("String value")
    default:
        print("Invalid value")
    }
}


for i in 0...10 where i % 2 == 0 {
    print(i)
}

enum Power {
    case fullyCharged
    case normal(percentage: Double)
    case outOfPower
}
let battery = Power.normal(percentage: 0.1)

switch battery {
case .normal(let percentage) where percentage <= 0.1:
    print("Almost out of power")
case .normal(let percentage) where percentage >= 0.8:
    print("Almost fully charged")
default:
    print("Normal battery status")
}

if case .normal(let percentage) = battery,
    case 0...0.1 = percentage {
    print("Almost out of power")
}

let username = "myname"
let password = 123456

if case ("myname", 123456) = (username, password) {
    print("correct")
}

// Swift标准库中实现了Range ~= Value 没有实现Value ~= Range
// 重载它，实现Value ~= Range
func ~=<T>(value: T, pattern: ClosedRange<T>) -> Bool {
    return pattern.contains(value)
}

if case .normal(let percentage) = battery,
    case percentage = 0...0.1 {
    print("Almost out of power")
}
