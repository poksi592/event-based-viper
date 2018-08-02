//
//  TopHighlightsSectionViewModel.swift
//  EventEmitterDemo
//
//  Created by Mladen Despotovic on 01.08.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import Foundation

class TopHighlightsSectionViewModel {
    
    var isExpanded = false
    let topHighlightViewModels: [TopHighlightViewModel]
    
    init(topHighlightViewModels: [TopHighlightViewModel]) {
        
        self.topHighlightViewModels = topHighlightViewModels
    }
}

