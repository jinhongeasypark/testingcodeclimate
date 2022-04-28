//
//  testingTests.swift
//  testingTests
//
//  Created by jk on 2022-04-28.
//

import XCTest
@testable import testing

class NetworkServiceMock: NetworkService {
    let e: XCTestExpectation
    init(e: XCTestExpectation) {
        self.e = e
    }
    func callNetwork(completion: @escaping (Result<Void, Error>) -> Void) {
        completion(.success(()))
        e.fulfill()
    }
}

class testingTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let e = expectation(description: "e")
        let mock = NetworkServiceMock(e: e)
        let sut = ContentViewModel(network: mock)
        sut.buttonTapped()
        waitForExpectations(timeout: 1)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
