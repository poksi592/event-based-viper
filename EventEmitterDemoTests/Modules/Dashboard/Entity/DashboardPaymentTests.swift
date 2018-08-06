//
//  DashboardPaymentTests.swift
//  EventEmitterDemoTests
//
//  Created by Mladen Despotovic on 06.08.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import XCTest
@testable import EventEmitterDemo

class DashboardPaymentTests: XCTestCase {
    
    var bundle: Bundle?
    
    override func setUp() {
        
        super.setUp()
        bundle = Bundle(for: type(of: self))
    }
    
    override func tearDown() {
        
        bundle = nil
        super.tearDown()
    }
    
    func test_fullPayment() {
        
        // GIVEN We have a properly structured Full3Payments.json file containing 3 objects
        // AND we can successfuly create a collection object from it
        // WHEN we run JSONDecoder through the collection
        // THEN we get collection of 3 DashboardPayment objects
        
        // Prepare
        let filePath = bundle?.path(forResource: "Full3Payments", ofType: "json")
        let dataObject = try! Data(contentsOf: URL(fileURLWithPath: filePath!))
        let responseDict = try! JSONSerialization.jsonObject(with: dataObject, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
        let paymentsDict = responseDict!["response"] as? [Any]
        
        // Execute
        let payments: [DashboardPayment] = paymentsDict!.compactMap { (payments) in
            
            guard let dataObject = try? JSONSerialization.data(withJSONObject: payments,
                                                               options: .prettyPrinted),
                let payment = try? JSONDecoder().decode(DashboardPayment.self, from: dataObject) else {
                    return nil
            }
            return payment
        }
        
        // Test
        XCTAssertEqual(payments.count, 3)
        XCTAssertEqual(payments[0].id, 24310)
        XCTAssertEqual(payments[1].amount, 2454.2)
        XCTAssertEqual(payments[2].accountNo, "DE245234532451")
    }
    
    func test_badJsonPayment() {
        
        // GIVEN We have BadJsonPayment.json file containing 3 objects, but missing "response" key
        // WHEN we run JSONDecoder through the collection
        // THEN we don't get collection of responses
        
        // Prepare
        let filePath = bundle?.path(forResource: "BadJsonPayment", ofType: "json")
        let dataObject = try! Data(contentsOf: URL(fileURLWithPath: filePath!))
        
        // Execute
        let responseDict = try? JSONSerialization.jsonObject(with: dataObject, options: JSONSerialization.ReadingOptions.allowFragments)
        
        // Test
        XCTAssertNotNil(dataObject)
        XCTAssertNil(responseDict)
    }
    
    func test_IDMissingJsonPayment() {
        
        // GIVEN We have  IDMissingJsonPayment.json file containing 3 objects, but missing 'id' variable
        // WHEN we run JSONDecoder through the collection
        // THEN we get collection of 3 JSON objects, but JSONDecoder fails to create collection of DashboardPayment objects, because the 'id' variable is not optional
        
        // Prepare
        let filePath = bundle?.path(forResource: "IDMissingJsonPayment", ofType: "json")
        let dataObject = try! Data(contentsOf: URL(fileURLWithPath: filePath!))
        let responseDict = try! JSONSerialization.jsonObject(with: dataObject, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
        let paymentsDict = responseDict!["response"] as? [Any]
        
        // Execute
        let payments: [DashboardPayment] = paymentsDict!.compactMap { (payments) in
            
            guard let dataObject = try? JSONSerialization.data(withJSONObject: payments,
                                                               options: .prettyPrinted),
                let payment = try? JSONDecoder().decode(DashboardPayment.self, from: dataObject) else {
                    return nil
            }
            return payment
        }
        
        // Test
        XCTAssertEqual(payments.count, 0)
    }
}
