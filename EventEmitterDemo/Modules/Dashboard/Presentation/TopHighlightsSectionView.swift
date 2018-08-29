//
//  TopHighlightsSectionView.swift
//  EventEmitterDemo
//
//  Created by Mladen Despotovic on 31.07.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import Foundation
import UIKit

class TopHighlightsSectionView: UIStackView, EventEmitting {
    
    // MARK: EventEmitting
    typealias EventEmitter = DashboardEventEmitter
    var eventEmitter: DashboardEventEmitter? = nil
    //
    
    var highlighViews: [WeakContainer<TopHighlightView>] = []
    
    override func awakeFromNib() {
        
        spacing = 6.0
    }
    
    func updateSectionView(with model: TopHighlightsSectionViewModel) {
        
        if highlighViews.isEmpty {

            model.topHighlightViewModels.enumerated().forEach { [weak self] (index, viewModel) in
            
                let topHighlightView = TopHighlightView.instantiateFromNib() as! TopHighlightView
                topHighlightView.setup(with: viewModel)
                self?.addArrangedSubview(topHighlightView)
                self?.highlighViews.append(WeakContainer(value: topHighlightView))
            }
        }
        else {
            model.topHighlightViewModels.enumerated().forEach { [weak self] (index, viewModel) in

                self?.highlighViews[index].value?.setup(with: viewModel)
            }
        }
        resizeView(isExpanded: model.isExpanded)
    }
    
    func resizeView(isExpanded: Bool) {
        
        highlighViews.forEach { view  in
            
            view.value?.from.isHidden = !isExpanded
            view.value?.text.isHidden = !isExpanded
        }
        
        // Emitting the event
        if isExpanded == true {
            eventEmitter?.notify(eventPayload: ["analytics": [DashboardEvent.expandTopHighlights.rawValue: ""]])
        }
    }
}
