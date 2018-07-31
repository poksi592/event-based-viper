//
//  DashboardViewController.swift
//  EventEmitterDemo
//
//  Created by Mladen Despotovic on 27.07.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import Foundation
import UIKit

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var highlights: TopHighlightsSectionView!
    var presenter: DashboardPresenter?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Update Highlighs UIStackView Section
        presenter?.getHighlights() { [weak self] highlightsViewModels in
            
            if let highlightsViewModels = highlightsViewModels {
                self?.highlights.addSubviews(with: highlightsViewModels)
            }
        }
    }
}
