//
//  TopHighlightsSectionView.swift
//  EventEmitterDemo
//
//  Created by Mladen Despotovic on 31.07.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import Foundation
import UIKit

class TopHighlightsSectionView: UIStackView {
    
    var highlighViews: [WeakContainer<TopHighlightView>] = []
    var isExpanded = false
    
    override func awakeFromNib() {
        
        spacing = 6.0

        gestureRecognizers = nil
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        addGestureRecognizer(tapGestureRecognizer)
        isUserInteractionEnabled = true
    }
    
    func addSubviews(with models: [TopHighlightViewModel]) {
        
        models.forEach { [weak self] viewModel in
            
            let topHighlightView = TopHighlightView.instantiateFromNib() as! TopHighlightView
            topHighlightView.setup(with: viewModel)
            self?.addArrangedSubview(topHighlightView)
            self?.highlighViews.append(WeakContainer(value: topHighlightView))
        }
    }
    
    @objc func tapped(sender: UITapGestureRecognizer) {
        
        highlighViews.forEach { view  in
            
            view.value?.from.isHidden = isExpanded
            view.value?.text.isHidden = isExpanded
        }
        isExpanded = !isExpanded
    }
}
