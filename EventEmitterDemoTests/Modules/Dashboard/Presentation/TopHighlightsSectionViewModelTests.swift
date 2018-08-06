//
//  TopHighlightsSectionViewModelTests.swift
//  EventEmitterDemoTests
//
//  Created by Mladen Despotovic on 06.08.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import XCTest
@testable import EventEmitterDemo

class TopHighlightsSectionViewModelTests: XCTestCase {
    
    func test_emptyModelArray() {
        
        // GIVEN we have empty array of TopHighlightViewModel types
        // WHEN we initiate TopHighlightsSectionViewModel object with TopHighlightViewModel array
        // THEN we get and instance of TopHighlightsSectionViewModel
        // THEN instance's 'isExpanded' property is false
        // THEN instance's 'topHighlightViewModels' array property is empty
        
        // Prepare
        let models = [TopHighlightViewModel]()
        
        // Execute
        let sectionViewModel = TopHighlightsSectionViewModel(topHighlightViewModels: models)
        
        // Test
        XCTAssertNotNil(sectionViewModel)
        XCTAssertEqual(sectionViewModel.isExpanded, false)
        XCTAssertEqual(sectionViewModel.topHighlightViewModels.count, 0)
    }
    
    func test_2ModelArray() {
        
        // GIVEN we have array with 2 TopHighlightViewModel objects
        // WHEN we initiate TopHighlightsSectionViewModel object with TopHighlightViewModel array
        // THEN we get and instance of TopHighlightsSectionViewModel
        // THEN instance's 'isExpanded' property is false
        // THEN instance's 'topHighlightViewModels' array property has 2 TopHighlightViewModel object
        
        // Prepare
        let topHighlight1 = TopHighlight(type: "C1",
                                         title: "Double charge, perhaps?",
                                         amount: -246.40,
                                         from: "Fellow Brothers Ltd.",
                                         text: "Amount was double the last time, when it was -123.20")
        let topHighlight2 = TopHighlight(type: "N1",
                                         title: "Double charge, perhaps?",
                                         amount: 246.40,
                                         from: "Fellow Brothers Ltd.",
                                         text: "Amount was double the last time, when it was -123.20")
        let topHighlightViewModel1 = TopHighlightViewModel(model: topHighlight1)
        let topHighlightViewModel2 = TopHighlightViewModel(model: topHighlight2)
        
        let models = [topHighlightViewModel1, topHighlightViewModel2]
        
        // Execute
        let sectionViewModel = TopHighlightsSectionViewModel(topHighlightViewModels: models)
        
        // Test
        XCTAssertNotNil(sectionViewModel)
        XCTAssertEqual(sectionViewModel.isExpanded, false)
        XCTAssertEqual(sectionViewModel.topHighlightViewModels.count, 2)
    }
    
}
