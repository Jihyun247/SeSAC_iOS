//
//  APIServiceTests.swift
//  Week23_TestTests
//
//  Created by 김지현 on 2022/03/03.
//

import XCTest
@testable import Week23_Test

class APIServiceTests: XCTestCase {
    
    var sut: APIService!

    override func setUpWithError() throws {

        try super.setUpWithError()
        sut = APIService()
    }

    override func tearDownWithError() throws {

        sut = nil
        try tearDownWithError()
    }

    // CallRequest > number 1-45
    func testExample() throws {

        sut.number = 100
        print("==\(sut.number)==")
        sut.callRequest { num in
            print("클로저 구문")
            XCTAssertLessThanOrEqual(self.sut.number, 45)
            XCTAssertGreaterThan(self.sut.number, 1)
        }
        print("==============")
        // 출력해보면 클로저가 실행이 안됨
    }
    
    // 콜백에서 테스트하고 싶을 시 밑의 메서드를 활용해서 할 수 있다
    // 비동기 : expection, fulfill, wait
    // 테스트 메서드에서 expectation 하나만 사용하도록 권장
    
    // 근데 만약 네트워크 문제로 테스트 실패한다면 ? (아이폰 네트워크 응답x, API 서버 점검, API 지연 등등)
    // => Mock, DummyData를 이용하게 된다. (테스트가 가능한 더미 객체를 만들어 네트워크 문제가 생긴다면 더미 객체로 데이터를 갈아끼운다!)
    // => ( Dummy, Stub, Fake, Spy, Mock )-테스트 더블 : 테스트 코드와 상호작용을 할 수 있는 가짜 객체 생성 (ex. 스턴트 더블에서 유래)
    // => 속도 개선, 테스트 대상 격리, 예측 불가능한 상황 없도록
    func testExample2() throws {
        
        let promise = expectation(description: "Wating Lotto Number, Completion Handler Invoked")
        
        sut.number = 100
        sut.callRequest { num in
            XCTAssertLessThanOrEqual(self.sut.number, 45)
            XCTAssertGreaterThan(self.sut.number, 1)
            promise.fulfill() // expectation으로 정의한 테스트 조건을 충족한 시점에 호출
        }
        
        // 만약 fulfill이 여러개라면 모든 fulfill을 기다렸다가 실행됨
        
        wait(for: [promise], timeout: 5) // timeout : 5초가 지나면 무조건 실패로 간주.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
