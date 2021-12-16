import Foundation

var sample = Array(repeating: "가", count: 100)

sample.count
sample.capacity

sample.append(contentsOf: Array(repeating: "나", count: 100))

sample.count
sample.capacity

var sample2: [Int] = []

for i in 1...200 {
    sample2.append(i)
    sample2.count
    sample2.capacity
}

var str = "Hello World - Hello".replacingOccurrences(of: " ", with: "_").replacingOccurrences(of: "-", with: " ")
var t = "Squid Game".replacingOccurrences(of: " ", with: "_").lowercased()
