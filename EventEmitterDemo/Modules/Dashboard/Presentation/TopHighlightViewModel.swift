//
//  TopHighlightViewModel.swift
//  EventEmitterDemo
//
//  Created by Mladen Despotovic on 31.07.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import Foundation
import UIKit

struct TopHighlightViewModel {
    
    let title: String
    let amount: String
    let from: String
    let text: String
    let imagePath: String?
    
    init(model: TopHighlight) {
        
        self.title = model.title
        
        let formatter = NumberFormatter()
        formatter.currencySymbol = "€"
        formatter.numberStyle = .currency
        self.amount = formatter.string(from: NSNumber(value: model.amount)) ?? ""
        
        self.from = model.from
        self.text = model.text
        
        switch model.type {
        case "C1":
            self.imagePath = "alert-red"
        case "S2":
            self.imagePath = "alert-green"
        case "A1":
            self.imagePath = "alarm"
        default:
            self.imagePath = nil
        }
    }
}
