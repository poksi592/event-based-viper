//
//  TopHighlightViewModelTests.swift
//  EventEmitterDemoTests
//
//  Created by Mladen Despotovic on 06.08.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import XCTest
@testable import EventEmitterDemo

class TopHighlightViewModelTests: XCTestCase {
    
    func test_stringModelProperties() {
        
        // Prepare
        let topHighlight = TopHighlight(type: "C1",
                                        title: "Double charge, perhaps?",
                                        amount: -246.40,
                                        from: "Fellow Brothers Ltd.",
                                        text: "Amount was double the last time, when it was -123.20")
        
        // Execute
        let topHighlightViewModel = TopHighlightViewModel(model: topHighlight)
        
        // Test
        XCTAssertEqual(topHighlightViewModel.title, "Double charge, perhaps?")
        XCTAssertEqual(topHighlightViewModel.from, "Fellow Brothers Ltd.")
        XCTAssertEqual(topHighlightViewModel.text, "Amount was double the last time, when it was -123.20")
    }
    
    func test_negativeAmount() {
        
        // Prepare
        let topHighlight = TopHighlight(type: "C1",
                                        title: "Double charge, perhaps?",
                                        amount: -246.40,
                                        from: "Fellow Brothers Ltd.",
                                        text: "Amount was double the last time, when it was -123.20")
        
        // Execute
        let topHighlightViewModel = TopHighlightViewModel(model: topHighlight)
        
        // Test
        XCTAssertEqual(topHighlightViewModel.amount.prefix(1), "-")
    }
    
    func test_positiveAmount() {
        
        // Prepare
        let topHighlight = TopHighlight(type: "C1",
                                        title: "Double charge, perhaps?",
                                        amount: 246.40,
                                        from: "Fellow Brothers Ltd.",
                                        text: "Amount was double the last time, when it was -123.20")
        
        // Execute
        let topHighlightViewModel = TopHighlightViewModel(model: topHighlight)
        
        // Test
        XCTAssertNotEqual(topHighlightViewModel.amount.prefix(1), "-")
    }
    
    func test_mappingTypeC1ToImagePath() {
        
        // Prepare
        let topHighlight = TopHighlight(type: "C1",
                                        title: "Double charge, perhaps?",
                                        amount: 246.40,
                                        from: "Fellow Brothers Ltd.",
                                        text: "Amount was double the last time, when it was -123.20")
        
        // Execute
        let topHighlightViewModel = TopHighlightViewModel(model: topHighlight)
        
        // Test
        XCTAssertEqual(topHighlightViewModel.imagePath, "alert-red")
    }
    
    func test_mappingTypeS2ToImagePath() {
        
        // Prepare
        let topHighlight = TopHighlight(type: "S2",
                                        title: "Double charge, perhaps?",
                                        amount: 246.40,
                                        from: "Fellow Brothers Ltd.",
                                        text: "Amount was double the last time, when it was -123.20")
        
        // Execute
        let topHighlightViewModel = TopHighlightViewModel(model: topHighlight)
        
        // Test
        XCTAssertEqual(topHighlightViewModel.imagePath, "alert-green")
    }
    
    func test_mappingTypeA1ToImagePath() {
        
        // Prepare
        let topHighlight = TopHighlight(type: "A1",
                                        title: "Double charge, perhaps?",
                                        amount: 246.40,
                                        from: "Fellow Brothers Ltd.",
                                        text: "Amount was double the last time, when it was -123.20")
        
        // Execute
        let topHighlightViewModel = TopHighlightViewModel(model: topHighlight)
        
        // Test
        XCTAssertEqual(topHighlightViewModel.imagePath, "alarm")
    }
    
    func test_mappingOtherTypesToNilImagePath() {
        
        // Prepare
        let topHighlight = TopHighlight(type: "N1",
                                        title: "Double charge, perhaps?",
                                        amount: 246.40,
                                        from: "Fellow Brothers Ltd.",
                                        text: "Amount was double the last time, when it was -123.20")
        
        // Execute
        let topHighlightViewModel = TopHighlightViewModel(model: topHighlight)
        
        // Test
        XCTAssertNil(topHighlightViewModel.imagePath)
    }
    
    func test_euroCurrencySuffix() {
        
        // Prepare
        let topHighlight = TopHighlight(type: "N1",
                                        title: "Double charge, perhaps?",
                                        amount: 246.40,
                                        from: "Fellow Brothers Ltd.",
                                        text: "Amount was double the last time, when it was -123.20")
        
        // Execute
        let topHighlightViewModel = TopHighlightViewModel(model: topHighlight)
        
        // Test
        XCTAssertEqual(topHighlightViewModel.amount.prefix(1), "€")
    }
}

