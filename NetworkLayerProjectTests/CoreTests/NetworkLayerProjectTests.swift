//
//  NetworkLayerProjectTests.swift
//  NetworkLayerProjectTests
//
//  Created by Vinayak Putta on 14/01/24.
//

import XCTest

@testable import NetworkLayerProject

final class NetworkHandlerTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /**
        Test for Success everything is working fine
     */
    func testFetchDataForSuccess() throws {
        let urlString = "https://www.test.com"
        let mockNetworkStore = MockNetworkStore()
        mockNetworkStore.stub(url: urlString, for: Data())
        let mockClient = MockHTTPClient(networkStore: mockNetworkStore)
        
        let exception = XCTestExpectation(description: "Data fetch Exception")
        NetworkHandler.fetchData(with: mockClient, urlString: urlString) { result in
            if case .failure(let failure) = result {
                XCTFail("\(failure.apiErrorString)")
            } else {
                exception.fulfill()
            }
        }
        
        
        wait(for: [exception], timeout: 0.5)
    }
    
    /**
        Test for failure request with error - request not found when data not stubbed
     */
    func testFetchDataForFailure() throws {
        let urlString = "https://www.test.com"
        let mockNetworkStore = MockNetworkStore()
        mockNetworkStore.stub(url: urlString, for: nil)
        let mockClient = MockHTTPClient(networkStore: mockNetworkStore)
        
        let expectation = XCTestExpectation(description: "Data fetch failure Exception")
        NetworkHandler.fetchData(with: mockClient, urlString: urlString, isNetworkOnlyRequest: true) { result in
            if case .failure(let failure) = result {
                XCTAssertEqual(failure.apiErrorString, APIError.invalidStatusCode(statusCode: 404).apiErrorString)
                expectation.fulfill()
            }
        }
        
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    
    /**
       Async - Test for Success when everything is mocked properly
     */
    func testAsyncFetchDataForSuccess() async throws {
        let urlString = "https://www.test.com"
        let mockNetworkStore = MockNetworkStore()
        mockNetworkStore.stub(url: urlString, for: Data())
        let mockClient = MockHTTPClient(networkStore: mockNetworkStore)
        
        let exception = XCTestExpectation(description: "Data fetch Exception")

        _ = try await NetworkHandler.fetchData(with: mockClient, urlString: urlString)
        exception.fulfill()
        
        
    }
    
    /**
     Async - Test for failure request with error - request not found when data not stubbed
     */
    func testAsyncFetchDataForFailure() async throws {
        let urlString = "https://www.test.com"
        let mockNetworkStore = MockNetworkStore()
        mockNetworkStore.stub(url: urlString, for: nil)
        let mockClient = MockHTTPClient(networkStore: mockNetworkStore)
        
        let exception = XCTestExpectation(description: "Data fetch failure Exception")
        
        do {
           _ = try await NetworkHandler.fetchData(with: mockClient, urlString: urlString, isNetworkOnlyRequest: true)
        } catch {
            if let error = error as? APIError {
                XCTAssertEqual(error.apiErrorString, APIError.invalidStatusCode(statusCode: 404).apiErrorString)
                exception.fulfill()
            }
        }

        await fulfillment(of: [exception])
    }

}


// With test found following issues in my code
// 1. Forgot to call completion call inside NetworkManager if the data was nil. due to which when all parsing was success but data was nil and no completion was called causing time execced error

// 2. Forgot to add return statements after each completion call which caused throwing multiple error in test when failed
