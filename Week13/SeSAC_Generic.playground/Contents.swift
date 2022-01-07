var apple = 8
var banana = 3

print(apple,banana)
swap(&apple, &banana)
print(apple,banana)

// 각 타입마다 함수를 다 일일히 작성해주어야 하는 불편함

func swapTwoInt(a: inout Int, b: inout Int) {
    let tempA = a
    a = b
    b = tempA
}

func swapTwoDouble(a: inout Double, b: inout Double) {
    let tempA = a
    a = b
    b = tempA
}

func swapTwoString(a: inout String, b: inout String) {
    let tempA = a
    a = b
    b = tempA
}

var fruit1 = "사과"
var fruit2 = "바나나"
swapTwoString(a: &fruit1, b: &fruit2)

print(fruit1, fruit2)

// -----------------------------------------------------------------

func swapTwoValues<T>(a: inout T , b: inout T) {
    let tempA = a
    a = b
    b = tempA
}

var test1 = 2.2
var test2 = 6.6

swapTwoValues(a: &test1, b: &test2)

func total(a: [Int]) -> Int {
    return a.reduce(0, +)
}

func total(a: [Double]) -> Double {
    return a.reduce(0, +)
}

func total(a: [Float]) -> Float {
    return a.reduce(0, +)
}

// -----------------------------------------------------------------

//func total<T>(a: [T]) -> T {
//    에러나는 이유 : 0은 Int이다 T는 타입이 안정해져있는데 0을 사용함으로서 Int가 초기값이 됨, 그리고 + 또한 숫자 연산자 -> T를 Numeric/AdditiveArithmetic 으로 타입 제약 걸기
//    return a.reduce(0, +)
//}
func total<T: Numeric>(a: [T]) -> T {
    return a.reduce(0, +)
}

total(a: [3.2, 5.6, 4.3, 4.4])

// -----------------------------------------------------------------

struct Stack<T> {
    var items = [T]()
    
    mutating func push(_ item: T) {
        items.append(item)
    }
    
    mutating func pop() -> T {
        items.removeLast()
    }
}

extension Stack {
    var topElement: T? {
        return self.items.last
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("안")
stackOfStrings.push("녕")
stackOfStrings.push("하")
stackOfStrings.push("세")
stackOfStrings.push("요")
stackOfStrings.push("!")

stackOfStrings.pop()

var array: [String] = []
var array2 = Array<String>()

// -----------------------------------------------------------------

func equal<T: Equatable>(a: T, b: T) -> Bool {
    return a == b
}

equal(a: 3, b: 4)

class Animal: Equatable {
    
    static func == (lhs: Animal, rhs: Animal) -> Bool {
        return lhs == rhs
    }
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

let one = Animal(name: "고양이")
let two = Animal(name: "고양이")

one == two

equal(a: one, b: two)

// -----------------------------------------------------------------

import UIKit

class ViewController: UIViewController {
    
    func transitionViewController<T: UIViewController>(sb: String, vc: T) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "VC") as! T
        self.present(vc, animated: true, completion: nil)
    }
}
