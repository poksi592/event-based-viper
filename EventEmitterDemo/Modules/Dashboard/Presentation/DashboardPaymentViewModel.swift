//
//  DashboardPaymentViewModell.swift
//  EventEmitterDemo
//
//  Created by Mladen Despotovic on 02.08.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import Foundation

struct DashboardPaymentViewModel {
    
    let id: String
    let date: String
    let amount: String
    let accountNo: String
    let recipientAccountNo: String
    let recipientName: String
    let description: String
    
    init(model: DashboardPayment) {
        
        self.id = String(model.id)
        
        let date = Date(timeIntervalSince1970: model.date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.current
        self.date = dateFormatter.string(from: date)

        self.amount = NumberFormatter.localizedString(from: NSNumber.init(value: model.amount),
                                                      number: .currency)
        self.accountNo = model.accountNo
        self.recipientAccountNo = model.recipientAccountNo
        self.recipientName = model.recipientName
        self.description = model.description
    }
}
