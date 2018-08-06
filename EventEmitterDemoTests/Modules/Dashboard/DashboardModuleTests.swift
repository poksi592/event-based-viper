//
//  DashboardModuleTests.swift
//  EventEmitterDemoTests
//
//  Created by Mladen Despotovic on 06.08.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import XCTest
@testable import EventEmitterDemo

class DashboardModuleTests: XCTestCase {
    
    func test_route() {
        
        // Prepare
        let dashboardModule = DashboardModule()
        
        // Execute and Test
        XCTAssertEqual(dashboardModule.route, "dashboard")
    }
    
    func test_numberOfPaths() {
        
        // Prepare
        let dashboardModule = DashboardModule()
        
        // Execute and Test
        XCTAssertEqual(dashboardModule.paths.count, 1)
    }
    
    func test_paths() {
        
        // Prepare
        let dashboardModule = DashboardModule()
        
        // Execute and Test
        XCTAssertEqual(dashboardModule.paths[0], "/present")
    }
}
