//
//  LoginViewControllerTests.swift
//  Week23_TestTests
//
//  Created by 김지현 on 2022/03/02.
//

import XCTest
@testable import Week23_Test

class LoginViewControllerTests: XCTestCase {
    
    // system under test
    var sut: LoginViewController!

    override func setUpWithError() throws {
        
        sut = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController)
        sut.loadViewIfNeeded()
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//
//        // In UI tests it is usually best to stop immediately when a failure occurs.
//        continueAfterFailure = false
//
//        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
//        XCUIApplication().launch()
//
//        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    // BDD(Behavior Driven Development) : Given, When, Then
    // TDD(Test, Driven, Development: AAA
    func testLoginViewController_ValidID_ReturnTrue() throws {
        // Given, Arrange
        sut.idTextField.text = "wlgus@naver.com"
        // When, Act
        let valid = sut.isValidID()
        // Then, Assert
        XCTAssertTrue(valid, "@가 없거나 6글자 미만이라 안될 수 있다")
    }
    
    func testLoginViewController_invalidPassword_ReturnFalse() throws {
        
        sut.pwdTextField.text = "1234"
        
        let valid = sut.isValidPassword()
        
        XCTAssertFalse(valid, "패스워드 로직 확인")
    }
    
    func testLoginViewController_idTextField_ReturnNil() throws {
        
        sut.idTextField = nil
        
        let value = sut.idTextField
        
        XCTAssertNil(value)
    }

    func testExample() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
