//: [Previous](@previous)

import Foundation
import Security


func checkDateFormat(text: String) -> Bool {
    let format = DateFormatter()
    format.dateFormat = "yyyyMMdd"
    return format.date(from: text) == nil ? false : true
}

func validateUserInput(text: String) -> Bool {
    
    guard !(text.isEmpty) else {
        print("빈 값입니다")
        return false
    }
    
    guard Int(text) != nil else {
        print("숫자가 아닙니다")
        return false
    }
    
    // 사용자가 입력한 값이 날짜 형태로 변환이 되는 숫자인지 아닌지
    
    return true
}

if validateUserInput(text: "20220000") {
    print("검색을 할 수 있음")
}

// ----------------
// 오류 처리 패턴 do try catch / Error Protocol
// 컴파일러가 오류 타입을 인정
enum ValidationError: Error {
    case emptyString = 401
    case invalidInt = 402
    case invalidDate = 403
}

// enum 을 통해서 각 에러 별 상황을 정의해 준 다음 throw 구문을 통해서 에러 형태를 catch
// throws ??
func validateUserInputError(text: String) throws -> Bool {
    guard !(text.isEmpty) else {
        throw ValidationError.emptyString
    }
    
    guard Int(text) != nil else {
        throw ValidationError.invalidInt
    }
    
    guard checkDateFormat(text: text) else {
        throw ValidationError.invalidDate
    }
    
    return true
}

// try 와 throws
do {
    let result = try validateUserInputError(text: "20211111")
    print(result, "성공")
} catch ValidationError.emptyString {
    print("값이 비어있습니다." ValidationError.emptyString.rawValue)
} catch ValidationError.emptyString {
    print("숫자 값이 아닙니다.")
} catch ValidationError.emptyString {
    print("날짜 값이 아닙니다.")
}

do {
    let result = try validateUserInputError(text: "20211111")
    print(result, "성공")
} catch {
    
    switch error {
    case ValidationError.emptyString: print()
    case ValidationError.invalidInt: print()
    case ValidationError.invalidDate: print()
    }
}

let result = try! validateUserInputError(text: "20211111")
