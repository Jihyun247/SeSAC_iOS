import UIKit

//: [Next](@next)
// 고차함수: 1급 객체 / 매개변수와 반환값에 함수 -> map, filter, reduce

let student = [2.2, 5.0, 4.3, 3.3, 2.8, 1.5]
var resultStudent: [Double] = []
for i in student {
    if i >= 4.0 {
        resultStudent.append(i)
    }
}

print(resultStudent)

// Filter

let resultFilter = student.filter { value in
    value >= 4.0
}

let rFilter = student.filter { $0 >= 4.0 }

// 원하는 결과
let movieList = [
    "괴물": "박찬욱",
    "기생충": "봉준호",
    "인터스텔라": "크리스토퍼 놀란",
    "옥자": "봉준호"
]

let resultSort = movieList.sorted(by: { $0.key > $1.key })
print(resultSort)

//for (movieName, director) in movieList {
//    if director == "봉준호" {
//
//    }
//}

movieList.filter { $0.value == "봉준호" }.map{$0.key}
print(movieList)

// map
let number = [1,2,3,4,5,6,7,8,9]
var resultNumber: [Int] = []

for n in number {
    let value = n*2
    resultNumber.append(n*2)
}

let resultMap = number.map { $0 * 2 }
print(resultMap)

// reduce
let exam = [20, 40, 100, 90, 10, 70]
var totalCount = 0

for i in exam {
    totalCount += i
}

let resultTotalCount = exam.reduce(0) { $0 + $1 }
print(resultTotalCount)
