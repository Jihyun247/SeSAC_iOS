import UIKit // Foundation Framework

var email: String? = "abc@a.com"
var gender: Bool = true // 할당 연산자

// if-else를 통해 nil 예외 처리
if email == nil {
    print("이메일을 잘못 작성하셨습니다.")
} else {
    print("회원 정보 : \(email!), \(gender)") // 옵셔널언래핑 방법 중 느낌표를 통한 강제 해제
}

// 위의 if-else 구문을 삼항연산자를 통해 간략하게 -> ? ㅇㅇ:ㄴㄴ
email == nil ? print("이메일을 잘못 작성하셨습니다.") : print("회원 정보 : \(email!), \(gender)")

// 연락처를 기입하는 텍스트필드일 경우, 텍스트필드에 작성되는 모든 글자는 문자로 인식이 된다.
// 숫자를 입력하더라도 String
var phoneNumber = "01012345678"

//type(of: <#T##T#>) T -> 제네릭 ? 고급문법?
type(of: phoneNumber)

// 1. 숫자가 맞는지? 2. 숫자 카운트 3. 빈 칸

// 폰넘버에 문자열이 포함되어 있으면 형변환이 되지 않고 nil 이 되어 버린다 ! 이 nil에 대한 처리가 필요 !
var resultPhoneNumber = Int(phoneNumber) // int로 형변환
type(of: resultPhoneNumber)

Int8.min
Int8.max
UInt8.min
UInt8.max

var foodList: [String?] = ["랜디스도넛", nil, "아이스크림", "크로플"]
type(of: foodList)

foodList.insert("르뱅쿠키", at: 1)
foodList.append("바닐라타르트")
foodList.append(contentsOf: ["케이크팝", "노티드도넛"])
print(foodList)

// 배열 초기화 방법
var numberArray = [Int](1...100) // 1부터 100까지 한번에
var numberArray2 = Array(repeating: 0, count: 100) // 동일 요소 여러개 한번에
print(numberArray)

// shuffle 과 shuffled 의 차이점 !! -> -ed, ing : 원본 값은 건들지 않는다.
numberArray.shuffled() // 원본은 안바뀜
numberArray.shuffle() // 섞음
print(numberArray)

var sampleString = "SSAC"
sampleString.append(": iOS 앱 개발자 데뷔 과정")
print(sampleString)

var sampleString2 = "SAAC"
sampleString2.appending(": iOS 앱 개발자 데뷔 과정")
print(sampleString2)

// dictionaray key 고유해야 함, 순서가 없음.
var dictionary: [Int: String] = [1: "김지현", 2: "김예환", 3: "유은정"]
var dictionary2: Dictionary<Int, String> = [1: "김지현", 2: "김예환", 3: "유은정"]
print(dictionary)

dictionary[5] = "안녕"

dictionary[1]


// 신조어검색기
let wordDictionary = ["jmt": "존맛탱", "별다줄": "별걸 다 줄인다", "스드메": "스튜디오 드레스 메이크업"]
let userSearchText = "JMT".lowercased()

wordDictionary[userSearchText]

// set 집합
let set: Set<Int> = [1,3,4,5,5,6,7,7,7]
let set2: Set<Int> = [2,3,4,4,4,4,4]

set.intersection(set2)

print(set)
