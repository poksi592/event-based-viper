//
//  DashboardPaymentViewModelTests.swift
//  EventEmitterDemoTests
//
//  Created by Mladen Despotovic on 06.08.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import XCTest
@testable import EventEmitterDemo

class DashboardPaymentViewModelTests: XCTestCase {
    
    func test_stringModelProperties() {
        
        // Prepare
        let payment = DashboardPayment(id: 2454,
                                       date: 1532700972,
                                       amount: 345.60,
                                       accountNo: "DE245234532451",
                                       recipientAccountNo: "SI32346345",
                                       recipientName: "Rover Car Shop",
                                       description: "Servicing the crap")
        
        // Execute
        let paymentViewModel = DashboardPaymentViewModel(model: payment)
        
        // Test
        XCTAssertEqual(paymentViewModel.accountNo, "DE245234532451")
        XCTAssertEqual(paymentViewModel.recipientAccountNo, "SI32346345")
        XCTAssertEqual(paymentViewModel.recipientName, "Rover Car Shop")
        XCTAssertEqual(paymentViewModel.description, "Servicing the crap")
    }
    
    func test_amount() {
        
        // Prepare
        let payment = DashboardPayment(id: 2454,
                                       date: 1532700972,
                                       amount: 345.60,
                                       accountNo: "DE245234532451",
                                       recipientAccountNo: "SI32346345",
                                       recipientName: "Rover Car Shop",
                                       description: "Servicing the crap")
        
        // Execute
        let paymentViewModel = DashboardPaymentViewModel(model: payment)
        
        // Test
        XCTAssertEqual(paymentViewModel.amount, "€345.60")
    }
    
    func test_id() {
        
        // Prepare
        let payment = DashboardPayment(id: 2454,
                                       date: 1532700972,
                                       amount: 345.60,
                                       accountNo: "DE245234532451",
                                       recipientAccountNo: "SI32346345",
                                       recipientName: "Rover Car Shop",
                                       description: "Servicing the crap")
        
        // Execute
        let paymentViewModel = DashboardPaymentViewModel(model: payment)
        
        // Test
        XCTAssertEqual(paymentViewModel.id, "2454")
    }
    
    func test_date() {
        
        // Prepare
        let payment = DashboardPayment(id: 2454,
                                       date: 1532700972,
                                       amount: 345.60,
                                       accountNo: "DE245234532451",
                                       recipientAccountNo: "SI32346345",
                                       recipientName: "Rover Car Shop",
                                       description: "Servicing the crap")
        
        // Execute
        let paymentViewModel = DashboardPaymentViewModel(model: payment)
        
        // Test
        XCTAssertEqual(paymentViewModel.date, "7/27/18")
    }
}
