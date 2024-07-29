//
//  UserLoginProtocolOrientedTests.swift
//  ProtocolOrientedTests
//
//  Created by Jayakrishnan u on 7/29/24.
//

import XCTest
@testable import ProtocolOriented

final class UserLoginProtocolOrientedTests: XCTestCase {

    private var sut: RootViewModel!
    private var loginStorageService: MockLoginService!
    private var output: MockRootViewModelOutput!
    
    
    override func setUpWithError() throws {
        loginStorageService = MockLoginService()
        output = MockRootViewModelOutput()
        sut = RootViewModel(loginStorageService: loginStorageService)
        sut.output = output
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
        loginStorageService = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testShowLogin_whenLoginStorageReturnsEmptyTokens() {
        loginStorageService.storage = [:]
        sut.checkLogin()
        XCTAssertEqual(output.check.count, 1)
        XCTAssertEqual(output.check.first, .login)
    }
    
    func testShowLogin_whenLoginStorageReturnsUserAccessToken() {
        loginStorageService.storage["TEST_TOKEN"] = "12312"
        sut.checkLogin()
        XCTAssertEqual(output.check.count, 1)
        XCTAssertEqual(output.check.first, .mainApp)
    }
    
    func testShowLogin_whenLoginStorageReturnsEmptyString() {
        loginStorageService.storage["TEST_TOKEN"] = ""
        sut.checkLogin()
        XCTAssertEqual(output.check.count, 1)
        XCTAssertEqual(output.check.first, .login)
    }
}

class MockLoginService: LoginStorageService {
    var userAccessToken: String {
        return "TEST_TOKEN"
    }
    
    var storage: [String: String] = [:]
    
    func setUserAccessToken(token: String) {
        storage[userAccessToken] = token
    }
    
    func getUserAccessToken() -> String? {
        return storage[userAccessToken]
    }
    
    
}

class MockRootViewModelOutput: RootViewModelOutput {
    
    enum Check {
        case login
        case mainApp
    }
    
    var check: [Check] = []
    
    func showLogin() {
        check.append(.login)
    }
    
    func showMainApp() {
        check.append(.mainApp)
    }
    
    
}
