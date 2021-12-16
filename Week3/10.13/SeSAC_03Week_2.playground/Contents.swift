import UIKit

var greeting = "Hello, playground"

// MARK: - 옵셔널 바인딩 : if-let, guard-let
enum UserMissionStatus: String {
    // string value 는 초기화가 되어있지 않을 때엔 rawvalue 출력 시 변수명이 출력된다
    case missionFailed = "성공"
    case missionSucceed = "실패"
}
UserMissionStatus.missionFailed.rawValue

func checkNumber1(number: Int?) -> (UserMissionStatus, Int?) {
    if number != nil {
        return (.missionSucceed, number!)
    } else {
        return (.missionFailed, nil)
    }
}

func checkNumber2(number: Int?) -> (UserMissionStatus, Int?) {
    if let value = number {
        return (.missionSucceed, value)
    } else {
        return (.missionFailed, nil)
    }
}

func checkNumber3(number: Int?) -> (UserMissionStatus, Int?) {
    guard let value = number else {
        return (.missionFailed, nil)
    }
    
    return (.missionSucceed, value)
}

// MARK: - 타입 캐스팅 : 메모리의 인스턴스 타입은 바뀌지 않는다
let array: [Any] = [1, true, "안녕"]
let arrayInt: [Int]? = array as? [Int]

class Mobile {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

class AppleMobile: Mobile {
    let company: String = "애플"
}

class GoogleMobile: Mobile {
    let company: String = "구글"
}

let mobile = Mobile(name: "PHONE")
let apple = AppleMobile(name: "APPLE")
let google = GoogleMobile(name: "GOOGLE")

mobile is Mobile
mobile is AppleMobile
mobile is GoogleMobile

apple is Mobile
apple is AppleMobile
apple is GoogleMobile

google is Mobile
google is AppleMobile
google is GoogleMobile

let iPhone: Mobile = AppleMobile(name: "iPad")
iPhone.name

// 이 변수 이 타입으로 쓸 수 있어? 라고 확인 가능 - 옵셔널 바인딩과 같이 활용 가능
iPhone as? AppleMobile

if let value = iPhone as? AppleMobile {
    print("성공", value.company)
}

// MARK: - 클래스, 구조체

enum DrinkSize {
    case short, tall, grande, venti
}

struct DrinkStruct {
    let name: String
    var count: Int
    var size: DrinkSize
}

class DrinkClass {
    let name: String
    var count: Int
    var size: DrinkSize
    
    init(name: String, count: Int, size: DrinkSize) {
        self.name = name
        self.count = count
        self.size = size
    }
}

// struct 구조체는 init이 기본으로 제공됨
// struct 구조체 프로퍼티를 let으로 선언하면 프로퍼티 변경 불가 (아무리 변수가 var 이라 해도 !!)
var drinkStruct = DrinkStruct(name: "아메리카노", count: 3, size: .tall)
drinkStruct.count = 2
drinkStruct.size = .venti
print(drinkStruct.name, drinkStruct.count, drinkStruct.size)

// class 클래스는 init이 기본으로 제공 x
// class 프로퍼티를 let으로 선언해도 var 프로퍼티는 변경 가능
let drinkClass = DrinkClass(name: "블루베리 스무디", count: 2, size: .venti)
drinkClass.count = 5
drinkClass.size = .tall
print(drinkClass.name, drinkClass.count, drinkClass.size)

// 왜 ? - 메모리 관련

// 지연 저장 프로퍼티 : 변수 저장 프로퍼티, 초기화
struct Poster {
    var image: UIImage = UIImage(systemName: "star") ?? UIImage()
    
    init() {
        print("1000 Poster Initialized")
    }
    
}

struct MediaInformation {
    var mediaTitle: String
    var mediaRuntime: Int
    lazy var mediaPoster: Poster = Poster()
}

var media = MediaInformation(mediaTitle: "오징어게임", mediaRuntime: 333)
print("1")
media.mediaPoster
print("2")

// MARK: - 연산 프로퍼티 & 프로퍼티 감시자 => Swift5.1 PropertyWrapper (@Environment)
// 타입알리어스

class BMI {
    typealias BMIValue = Double
    
    // 프로퍼티 감시자
    var userName: String {
        willSet {
            print("닉네임 바뀔 예정: \(userName) -> \(newValue)")
        }
        didSet {
            changeNameCount += 1
            print("닉네임 변경 결과: \(oldValue) -> \(userName)")
        }
    }
    
    var changeNameCount = 0
    
    var userWeight: BMIValue
    var userHeight: BMIValue
    
    // 연산 프로퍼티
    var BMIResult: String {
        get {
            let bmiValue = (userHeight * userWeight) / userHeight
            let bmiStatus = bmiValue < 18.5 ? "저체중" : "정상 이상"
            return "\(userName)님의 BMI 지수는 \(bmiValue)으로, \(bmiStatus)입니다."
        }
        set {
            // newValue는 원래 있는 기능임 만약 직접 매개변수 만들어주고 싶으면 set(nickname)
            userName = newValue
        }
    }
    
    init(userName: String, userWeight: Double, userHeight: Double) {
        self.userName = userName
        self.userWeight = userWeight
        self.userHeight = userHeight
    }
}

let bmi = BMI(userName: "JIHYUN", userWeight: 48, userHeight: 163)
let result = bmi.BMIResult

print(result)

bmi.BMIResult = "YEAHWAN"
bmi.BMIResult = "HYEIN"
bmi.BMIResult = "YEONJOO"

print(bmi.BMIResult)
print(bmi.changeNameCount)

// MARK: - 타입 프로퍼티 (static)

class User {
    static let nickname = "고래밥"
    // 관찰 프로퍼티
    static var totalOrderCount = 0 {
        didSet {
            print("총 주문횟수: \(oldValue) -> \(totalOrderCount)로 증가")
        }
    }
    // 연산 프로퍼티
    static var orderProduct: Int {
        get {
            return totalOrderCount
        }
        set {
            totalOrderCount += newValue
        }
    }
}

// static 은 변수 선언 안해도, 바로 접근 가능

User.orderProduct = 10
User.totalOrderCount
User.orderProduct = 20
User.totalOrderCount

// MARK: - 타입 메서드 (static)

//class Point {
//    var x = 0.0
//    var y = 0.0
//
//    func moveBy(x: Double, y: Double) {
//        self.x += x
//        self.y += y
//    }
//}

// 클래스에선 자신의 "프로퍼티" 값을 "인스턴스 메서드" 내에서 변경 가능
// 구조체에서 자신의 "프로퍼티" 값을 "인스턴스 메서드" 내에서 변경하게 될 경우 메서드 앞에 mutating을 붙인다
struct Point {
    var x = 0.0
    var y = 0.0
    
    mutating func moveBy(x: Double, y: Double) {
        self.x += x
        self.y += y
    }
}

// 초기화 (static이 아닌 인스턴스 메서드를 사용하기 위해선 초기화 필요)
var somePoint = Point()
print("POINT: \(somePoint.x), \(somePoint.y)")
somePoint.moveBy(x: 3.0, y: 5.0)
print("POINT: \(somePoint.x), \(somePoint.y)")

class Coffee {
    static var name = "아메리카노"
    static var shot = 2
    
    // 타입 메서드는 오버라이딩 불가능
    static func plusShot() {
        shot += 1
    }
    
    // 그래서 생긴게 이거 ㅜ
    class func minusShot() {
        shot -= 1
    }
    
    func hello() {
        
    }
}

class Latte: Coffee {
    override class func minusShot() {
        print("타입 메서드를 상속받아 재정의 하고 싶을 경우, 부모 클래스에서 타입 메서드 선언할 때 static이 아니라 class를 쓰면 재정의할 수 있다")
    }
}

Latte.minusShot()

// MARK: - 싱글턴 패턴 (공부하자 !!!)

class UserDefaultHelper {
    static let shared = UserDefaultHelper()
    
    let userDefaults = UserDefaults.standard
    
    enum Key: String {
        case nickname, age, rate
    }
    
    var userNickname: String? {
        get {
            return userDefaults.string(forKey: Key.nickname.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.nickname.rawValue)
        }
    }
    
    var userAge: Int? {
        get {
            return userDefaults.integer(forKey: Key.age.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.age.rawValue)
        }
    }
    
    private init() {
        
    }
}

UserDefaultHelper.shared.userNickname = "고래밥"
UserDefaultHelper.shared.userAge = 15

UserDefaultHelper.shared.userNickname
UserDefaultHelper.shared.userAge

// 싱글턴패턴으로 정의한 클래스를 이렇게 사용하지 말기 ! (충돌 날 수 있다) let user = UserDefaultHelper()


// MARK: - Property Wrapper (추가적으로 할 예정)

// MARK: - 너무 어려워서 정리...

// 클래스와 구조체

//클래스
//클래스는 인스턴스메서드 내에서 프로퍼티 변경 가능
//구조체는 let 프로퍼티도 변수로 선언 시 메모리 참조 공간이 다르기 때문에 변경 가능

//구조체
//구조체는 인스턴스메서드 내에서 프로퍼티 변경 불가
//구조체는 let 프로퍼티는 변수로 선언 시 변경 불가
