//
//  ProtocolOrientedTests.swift
//  ProtocolOrientedTests
//
//  Created by Jayakrishnan u on 7/29/24.
//             
import XCTest
@testable import ProtocolOriented

final class ProtocolOrientedTests: XCTestCase {
    
    private var sut: UserViewModel!
    private var userService: MockUserService!
    private var output: MockUserViewModelOutput!
    
    override func setUpWithError() throws {
        userService = MockUserService()
        sut = UserViewModel(userService: userService)
        output = MockUserViewModelOutput()
        sut.output = output
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        userService = nil
    }
    
    func testUpdateView_whenAPISuccess() {
        let mockUser = User(id: 1, name: "Test User", email: "test@mail.com")
        userService.fetchUsersMockResult = .success(mockUser)
        sut.fetchUsers()
        XCTAssertEqual(output.updateViewArray.count, 1)
        XCTAssertEqual(output.updateViewArray.first?.user, "Test User")
    }
    
    func testUpdateView_whenAPIFailure() {
        userService.fetchUsersMockResult = .failure(.failedData)
        sut.fetchUsers()
        XCTAssertEqual(output.updateViewArray.count, 1)
        XCTAssertEqual(output.updateViewArray.first?.user, "No user")
    }

}

class MockUserService: UserService {
    var fetchUsersMockResult: Result<User, NetworkError>?
    
    func fetchUsers(completion: @escaping (Result<User, NetworkError>) -> Void) {
        if let result = fetchUsersMockResult {
            completion(result)
        }
    }
}

class MockUserViewModelOutput: UserViewModelOutput {
    var updateViewArray: [(user: String, email: String)] = []
    func updateView(user: String, email: String) {
        updateViewArray.append((user, email))
    }
}
