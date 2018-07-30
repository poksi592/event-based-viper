//
//  TopHighlightModel.swift
//  EventEmitterDemo
//
//  Created by Mladen Despotovic on 30.07.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import Foundation

struct TopHighlight: Codable {
    
    let title: String
    let amount: Decimal
    let recipientName: String
    let description: String
}
