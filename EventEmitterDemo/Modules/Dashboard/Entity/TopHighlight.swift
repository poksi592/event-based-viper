//
//  TopHighlightModel.swift
//  EventEmitterDemo
//
//  Created by Mladen Despotovic on 30.07.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import Foundation

struct TopHighlight: Codable {
    
    let type: String
    let title: String
    let amount: Double
    let from: String
    let text: String
}
