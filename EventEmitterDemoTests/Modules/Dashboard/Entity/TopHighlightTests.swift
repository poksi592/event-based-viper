//
//  TopHighlightTests.swift
//  EventEmitterDemoTests
//
//  Created by Mladen Despotovic on 06.08.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import XCTest
@testable import EventEmitterDemo

class TopHighlightTests: XCTestCase {
    
    var bundle: Bundle?
    
    override func setUp() {
        
        super.setUp()
        bundle = Bundle(for: type(of: self))
    }
    
    override func tearDown() {
        
        bundle = nil
        super.tearDown()
    }
    
    func test_fullTopHighlights() {
        
        // GIVEN We have a properly structured Full2TopHighlights.json file containing 2 objects
        // AND we can successfuly create a collection object from it
        // WHEN we run JSONDecoder through the collection
        // THEN we get collection of 2 TopHighlight objects
        
        // Prepare
        let filePath = bundle?.path(forResource: "Full2TopHighlights", ofType: "json")
        let dataObject = try! Data(contentsOf: URL(fileURLWithPath: filePath!))
        let responseDict = try! JSONSerialization.jsonObject(with: dataObject, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
        let topHighlightsDict = responseDict!["response"] as? [Any]
        
        // Execute
        let topHighlights: [TopHighlight] = topHighlightsDict!.compactMap { (highlights) in
            
            guard let dataObject = try? JSONSerialization.data(withJSONObject: highlights,
                                                               options: .prettyPrinted),
                let highlight = try? JSONDecoder().decode(TopHighlight.self, from: dataObject) else {
                    return nil
            }
            return highlight
        }
        
        // Test
        XCTAssertEqual(topHighlights.count, 2)
        XCTAssertEqual(topHighlights[0].type, "C1")
        XCTAssertEqual(topHighlights[1].amount, 82.00)
    }
    
    func test_badTopHighlight() {
        
        // GIVEN We have BadJsonTopHighlights.json file containing 2 objects, but missing "response" key
        // WHEN we run JSONDecoder through the collection
        // THEN we don't get collection of responses
        
        // Prepare
        let filePath = bundle?.path(forResource: "BadJsonTopHighlights", ofType: "json")
        let dataObject = try! Data(contentsOf: URL(fileURLWithPath: filePath!))
        
        // Execute
        let responseDict = try? JSONSerialization.jsonObject(with: dataObject, options: JSONSerialization.ReadingOptions.allowFragments)
        
        // Test
        XCTAssertNotNil(dataObject)
        XCTAssertNil(responseDict)
    }
    
    func test_TypeMissingJsonTopHighlights() {
        
        // GIVEN We have TypeMissingJsonTopHighlights.json file containing 2 objects, but missing 'type' variable
        // WHEN we run JSONDecoder through the collection
        // THEN we get collection of 3 JSON objects, but JSONDecoder fails to create collection of TopHighlight objects, because the 'type' variable is not optional
        
        // Prepare
        let filePath = bundle?.path(forResource: "TypeMissingJsonTopHighlights", ofType: "json")
        let dataObject = try! Data(contentsOf: URL(fileURLWithPath: filePath!))
        let responseDict = try! JSONSerialization.jsonObject(with: dataObject, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
        let topHighlightsDict = responseDict!["response"] as? [Any]
        
        // Execute
        let topHighlights: [TopHighlight] = topHighlightsDict!.compactMap { (highlights) in
            
            guard let dataObject = try? JSONSerialization.data(withJSONObject: highlights,
                                                               options: .prettyPrinted),
                let highlight = try? JSONDecoder().decode(TopHighlight.self, from: dataObject) else {
                    return nil
            }
            return highlight
        }
        
        // Test
        XCTAssertEqual(topHighlights.count, 0)
    }
}
