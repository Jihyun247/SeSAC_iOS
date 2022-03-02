//
//  UserTextFieldTest.swift
//  Week23_TestUITests
//
//  Created by 김지현 on 2022/03/02.
//

import XCTest

class UserTextFieldTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        app.launch()
        
        app.textFields["first_textfield"].tap()
        app.textFields["first_textfield"].typeText("안녕하세요")
        
        app.textFields["second_textfield"].tap()
        app.textFields["second_textfield"].typeText("1234")
        
        app.textFields["third_textfield"].tap()
        app.textFields["third_textfield"].typeText("1234")
        
        app.buttons["first_button"].tap()
        
        // 원하는 결과값과 같은 결과값이 나오는지 확인
        XCTAssertEqual(app.staticTexts.element(matching: .any, identifier: "result_label").label, "안녕하세요", "무엇을 수정해야 하는지, 어떤 메서드와 연관이 있을 수 있는지 작성")
    }

}
