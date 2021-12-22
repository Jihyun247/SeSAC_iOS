//: [Previous](@previous)

import Foundation

struct User: Encodable {
    var name: String
    var signUpDate: Date
    var age: Int
}

let users: [User] = [

    User(name: "Jack", signUpDate: Date(), age: 30),
    User(name: "Jihyun", signUpDate: Date(timeInterval: -86400, since: Date()), age: 23),
    User(name: "Emily", signUpDate: Date(timeIntervalSinceNow: 86400*2), age: 11)
]

dump(users)

let encode = JSONEncoder()
encode.outputFormatting = .prettyPrinted
//encode.dateEncodingStrategy = .iso8601
//encode.outputFormatting = .sortedKeys

let format = DateFormatter()
format.locale = Locale(identifier: "ko-KR")
encode.dateEncodingStrategy = .formatted(format)

do {
    // Data
    let jsonData = try JSONEncoder().encode(users)
    
    // Data to String
    guard let jsonString = String(data: jsonData, encoding: .utf8) else { fatalError("Failed") }
    
    print(jsonString)
} catch {
    print(error)
}

//: [Next](@next)
