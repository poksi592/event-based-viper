//
//  DashboardViewControllerTests.swift
//  EventEmitterDemoTests
//
//  Created by Mladen Despotovic on 06.08.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import XCTest
@testable import EventEmitterDemo

class DashboardViewControllerTests: XCTestCase {

    override func setUp() {
        super.setUp()

    }
    
    override func tearDown() {

        super.tearDown()
    }
    
    func test_setupSectionTap() {
        
        // GIVEN we instantiate DashboardViewController
        // AND call 'viewDidLoad' function
        // THEN setupSectionTap is called and tapGestureRecognizer is setup
        
        // Prepare
        let wireframe = DashboardWireframe()
        let parameters = ["presentationMode": "navigationStack",
                          "viewController": "DashboardViewControllerId"]
        let presenter = DashboardPresenter()
        let viewController = wireframe.presentViewController(ofType: DashboardViewController.self,
                                                             presenter: presenter,
                                                             parameters: parameters) as! UIViewController
        
        // Execute
        viewController.viewDidLoad()
        
        // Test
        XCTAssertNotNil(viewController.view.gestureRecognizers)
    }
    
}
