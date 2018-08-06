//
//  DashboardPresenterTests.swift
//  EventEmitterDemoTests
//
//  Created by Mladen Despotovic on 06.08.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import XCTest
@testable import EventEmitterDemo

class DashboardPresenterTests: XCTestCase {
    
    func test_init() {
        
        // Prepare and Execute
        let presenter: ModuleRoutable = DashboardPresenter.routable()
        
        // Test
        XCTAssertNotNil(presenter)
    }
    
    func test_paths() {
        
        // Prepare and Execute
        let paths = DashboardPresenter.getPaths()
        
        // Test
        XCTAssertEqual(paths.count, 1)
        XCTAssertEqual(paths[0], "/present")
    }
    
    func test_parametersAndCallbackProperties() {
        
        // GIVEN we instantiate DashboardPresenter
        // AND call 'route' function with 'parameters' and 'callback'
        // THEN properties with the same name get values passes to 'route' function
        
        // Prepare
        let presenter = DashboardPresenter.routable() as! DashboardPresenter

        // Execute
        presenter.route(parameters: ["parameter": "value1"], path: "/present") { (responseDict, responseData, urlResponse, error) in
        }
        
        // Test
        XCTAssertEqual(presenter.parameters, ["parameter": "value1"])
        XCTAssertNotNil(presenter.callback)
    }
    
    func test_callingPresentViewController() {
        
        // GIVEN we instantiate DashboardPresenter
        // AND call 'route' function with 'parameters' and 'callback'
        // THEN properties with the same name get values passes to 'route' function
        
        // Prepare
        let presenter = DashboardPresenter.routable() as! DashboardPresenter
        presenter.wireframe = MockDashboardWireframe()
        
        // Execute and Test
        presenter.route(parameters: ["parameter": "value1"], path: "/present") { (responseDict, responseData, urlResponse, error) in
        }
        let wireframe = presenter.wireframe as! MockDashboardWireframe
        XCTAssertTrue(wireframe.presentViewControllerIsCalled, "Should be called")
    }
    
    func test_getHighlightsIsCalled() {
        
        // GIVEN we instantiate DashboardPresenter
        // AND call 'getHighlights' function
        // THEN interactor's function 'getTopHighlights' is called
        
        // Prepare
        let presenter = DashboardPresenter.routable() as! DashboardPresenter
        presenter.interactor = MockDashboardInteractor()
        
        // Execute
        presenter.getHighlights { (topHighlights) in
        }
        
        // Test
        let interactor = presenter.interactor as! MockDashboardInteractor
        XCTAssertTrue(interactor.getTopHighlightsIsCalled, "Should be called")
    }
    
    func test_getHighlights() {
        
        // GIVEN we instantiate DashboardPresenter
        // AND call 'getHighlights' function
        // THEN interactor's function 'getTopHighlights' is called
        // THEN presenter's property 'topHighlightsSectionViewModel' gets value
        
        // Prepare
        let presenter = DashboardPresenter.routable() as! DashboardPresenter
        let testExpectation = expectation(description: "Test Expectation")
        
        // Execute and Test
        presenter.getHighlights { (sectionViewModel) in
            
            XCTAssertNotNil(sectionViewModel)
            XCTAssertNotNil(presenter.topHighlightsSectionViewModel)
            testExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_getLast10PaymentsIsCalled() {
        
        // GIVEN we instantiate DashboardPresenter
        // AND call 'getLastPayments' function
        // THEN interactor's function 'getLastPayments' is called
        
        // Prepare
        let presenter = DashboardPresenter.routable() as! DashboardPresenter
        presenter.interactor = MockDashboardInteractor()
        
        // Execute
        presenter.getLastPayments {
        }
        
        // Test
        let interactor = presenter.interactor as! MockDashboardInteractor
        XCTAssertTrue(interactor.getLast10PaymentsIsCalled, "Should be called")
    }
    
    func test_getLast10Payments() {
        
        // GIVEN we instantiate DashboardPresenter
        // AND call 'getLastPayments' function
        // THEN interactor's function 'getLastPayments' is called
        // THEN presenter's property 'dashboardPaymentViewModels' gets value
        
        // Prepare
        let presenter = DashboardPresenter.routable() as! DashboardPresenter
        let testExpectation = expectation(description: "Test Expectation")
        
        // Execute and Test
        presenter.getLastPayments {
            
            XCTAssertNotNil(presenter.dashboardPaymentViewModels)
            testExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_selectedPayment() {
        
        // GIVEN we instantiate DashboardPresenter
        // AND call 'selectedPayment' function with Int parameter
        // THEN property 'lastSelectedPayment' is not nil and has the value passed
        // THEN wireframe's function 'presentViewController' is called
        
        // Prepare
        let presenter = DashboardPresenter.routable() as! DashboardPresenter
        presenter.wireframe = MockDashboardWireframe()
        
        // Execute
        presenter.selectedPayment(index: 1)
        
        // Test
        let wireframe = presenter.wireframe as! MockDashboardWireframe
        XCTAssertTrue(wireframe.presentViewControllerIsCalled, "Should be called")
        XCTAssertNotNil(presenter.lastSelectedPayment)
        XCTAssertEqual(presenter.lastSelectedPayment, 1)
    }
    
    func test_expandCollapseTopHighlights_NoHighlightsLoaded() {
        
        // GIVEN we instantiate DashboardPresenter
        // AND we haven't called its 'getHighlights' function
        // THEN we get back nil
        
        // Prepare
        let presenter = DashboardPresenter.routable() as! DashboardPresenter
        
        // Execute
        let viewModels = presenter.expandCollapseTopHighlights()
        
        // Test
        XCTAssertNil(viewModels)
    }
    
    func test_expandCollapseTopHighlights_HighlightsLoaded() {
        
        // GIVEN we instantiate DashboardPresenter
        // AND we called its 'getHighlights' function
        // THEN we get back TopHighlightsSectionViewModel objexct
        
        // Prepare
        let presenter = DashboardPresenter.routable() as! DashboardPresenter
        let testExpectation = expectation(description: "Test Expectation")
        
        // Execute and Test
        presenter.getHighlights { (sectionViewModel) in
            
            let viewModels = presenter.expandCollapseTopHighlights()
            XCTAssertNotNil(viewModels)
            testExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
}

class MockDashboardWireframe: WireframeType {
    
    lazy var storyboard: UIStoryboard = UIStoryboard(name: "DashboardStoryboard", bundle: nil)
    var presentedViewControllers = [WeakContainer<UIViewController>]()
    var presentationMode: ModulePresentationMode = .none
    
    private(set) var presentViewControllerIsCalled = false
    
    func presentViewController<VC>(ofType: VC.Type,
                                            presenter: ModulePresentable,
                                            parameters: ModuleParameters?) -> RoutableViewControllerType? {
        
        presentViewControllerIsCalled = true
        return nil
    }
}

class MockDashboardInteractor: DashboardInteractor {
    
    private(set) var getTopHighlightsIsCalled = false
    private(set) var getLast10PaymentsIsCalled = false
    
    override func getTopHighlights(completion: @escaping ([TopHighlight]?, Error?) -> Void) {
        
        getTopHighlightsIsCalled = true
    }
    
    override func getLast10Payments(completion: @escaping ([DashboardPayment]?, Error?) -> Void) {
        
        getLast10PaymentsIsCalled = true
    }
}
