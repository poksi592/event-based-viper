//
//  DashboardInteractorTests.swift
//  EventEmitterDemoTests
//
//  Created by Mladen Despotovic on 06.08.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import XCTest
@testable import EventEmitterDemo

// This class is already mocked in this POC, so it's tested in a very limited way

class DashboardInteractorTests: XCTestCase {
    
    func test_getLast10Payments() {
        
        // GIVEN Main Bundle contains mocked JSON file Payment.json containign 10 objects
        // THEN we should receive array of DashboardPayment objects containing data from the file mapped 1:1 to DashboardPayment objects
        
        // Prepare
        let expectationForTest = expectation(description: "test")
        let dashboardInteractor = DashboardInteractor()
        
        // Execute and Test
        dashboardInteractor.getLast10Payments { (payments, error) in
            
            XCTAssertNil(error)
            XCTAssertEqual(payments?.count, 10)
            expectationForTest.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_getTopHighlights() {
        
        // GIVEN Main Bundle contains mocked JSON file TopHighlights.json containign some objects
        // THEN we should receive array of DashboardPayment objects containing data from the file mapped 1:1 to DashboardPayment objects
        
        // Prepare
        let expectationForTest = expectation(description: "test")
        let dashboardInteractor = DashboardInteractor()
        
        // Execute and Test
        dashboardInteractor.getTopHighlights { (highlights, error) in
            
            XCTAssertNil(error)
            XCTAssertGreaterThan(highlights!.count, 0)
            expectationForTest.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
