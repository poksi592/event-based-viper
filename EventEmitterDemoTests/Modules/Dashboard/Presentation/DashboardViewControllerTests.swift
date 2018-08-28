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
    
    func test_viewDidLoad() {
        
        // GIVEN we instantiate DashboardViewController
        // AND call 'viewDidLoad' function
        // THEN setupSectionTap is called and tapGestureRecognizer is setup
        
        // Prepare
        let wireframe = DashboardWireframe()
        let parameters = ["presentationMode": "root",
                          "viewController": "DashboardViewControllerId"]
        let presenter = DashboardPresenter()
        let viewController = wireframe.presentViewController(ofType: DashboardViewController.self,
                                                             presenter: presenter,
                                                             parameters: parameters) as! UIViewController
        
        // Execute
        viewController.viewDidLoad()
        
        // Test
        let dashboardViewController = viewController as! DashboardViewController
        XCTAssertNotNil(dashboardViewController.highlights.gestureRecognizers)
        XCTAssertNotEqual(dashboardViewController.highlights.highlighViews.count, 0)
    }
    
    func test_highlightsTapped() {
        
        // GIVEN we instantiate DashboardViewController
        // AND call 'highlightsTapped' function
        // THEN our presenter's 'expandCollapseTopHighlights' function is called
        
        // Prepare
        let wireframe = DashboardWireframe()
        let parameters = ["presentationMode": "root",
                          "viewController": "DashboardViewControllerId"]
        let presenter = MockDashboardPresenter()
        let viewController = wireframe.presentViewController(ofType: DashboardViewController.self,
                                                             presenter: presenter,
                                                             parameters: parameters) as! UIViewController
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(test_highlightsTapped))
        
        // Execute
        let dashboardViewController = viewController as! DashboardViewController
        dashboardViewController.highlightsTapped(sender: tapGestureRecognizer)
        
        // Test
        XCTAssertTrue(presenter.expandCollapseTopHighlightsCalled)
    }
}

class MockDashboardPresenter: DashboardPresenter {
    
    private(set) var expandCollapseTopHighlightsCalled = false
    override func expandCollapseTopHighlights() -> TopHighlightsSectionViewModel? {
        
        expandCollapseTopHighlightsCalled = true
        return nil
    }
    
    let viewModel: DashboardPaymentViewModel
    
    required init() {
        
        let model = DashboardPayment(id: 2343,
                                     date: 1532700972,
                                     amount: 345.50,
                                     accountNo: "DE345345354",
                                     recipientAccountNo: "SI453453",
                                     recipientName: "Turbo Pizza Ltd.",
                                     description: "Loads of Pizzas")
        self.viewModel = DashboardPaymentViewModel(model: model)
        super.init()
        self.dashboardPaymentViewModels = [viewModel]
    }
}
