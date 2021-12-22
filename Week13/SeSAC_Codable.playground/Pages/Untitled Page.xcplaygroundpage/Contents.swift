import UIKit

let json = """
{
"quote_content":"Your body is made to move so move it.",
"author_name":"Toni Sorenson"
}
"""

// class struct enum
struct Quote: Decodable {
    var quote: String
    var author: String
    
    enum CodingKeys: String, CodingKey { // 항상 내부적으로 생성이 되어 있음.
        case quote = "quote_content"
        case author = "author_name"
    }
}

// String -> Data
guard let data = json.data(using: .utf8) else {fatalError("Failed")}
print(data)

// Data -> Quote
do {
    let value = try JSONDecoder().decode(Quote.self, from: data)
    print(value.author, value.quote)
} catch {
    print(error)
}


// Meta Type
// String의 타입은 String.Type, 메타 타입은 클래스 구조체 열거형 등의 유형 자체를 가리킴
// Quote: 인스턴스에 대한 타입, Quote 구조체 자체의 타입은 뭐야? Quote.Type
let quote = Quote(quote: "명언명언", author: "Jihyun")
type(of: quote) // Quote.Type

struct User {
    var name = "고래밥"
    static let identifier = 1234567 // 타입 프로퍼티 ! -
}

let user = User()
// 이렇게 정의 하면 identifier은 접근 못함.
type(of: user).identifier // 이렇게 하면 접근 가능

// 이를 이용하면 컴파일 때가 아니라 런타임 때 타입을 알 수 있다.
let age: Any = 15
type(of: age)
