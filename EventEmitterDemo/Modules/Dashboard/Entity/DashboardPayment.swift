//
//  PaymentModel.swift
//  EventEmitterDemo
//
//  Created by Mladen Despotovic on 27.07.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import Foundation

struct DashboardPayment: Codable {
    
    let id: Int
    let date: Double
    let amount: Double
    let accountNo: String
    let recipientAccountNo: String
    let recipientName: String
    let description: String
}
