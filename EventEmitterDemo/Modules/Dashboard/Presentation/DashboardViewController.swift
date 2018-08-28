//
//  DashboardViewController.swift
//  EventEmitterDemo
//
//  Created by Mladen Despotovic on 27.07.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import Foundation
import UIKit

class DashboardViewController: UIViewController, RoutableViewControllerType {
    
    @IBOutlet weak var highlights: TopHighlightsSectionView!
    
    var presenter: ModulePresentable?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Setup Expand-collapse GR
        setupSectionTap()
        
        // Update Highlighs UIStackView Section
        if let presenter = presenter as? DashboardPresenter {
            
            presenter.getHighlights() { [weak self] viewModel in
                
                if let viewModel = viewModel {
                    self?.highlights.updateSectionView(with: viewModel)
                }
            }
            
            // Pass event emitter to section view
            highlights.eventEmitter = presenter.eventEmitter
        }
    }
    
    // MARK: Expand-collapse
    func setupSectionTap() {
        
        view.gestureRecognizers = nil
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(highlightsTapped))
        highlights.addGestureRecognizer(tapGestureRecognizer)
        highlights.isUserInteractionEnabled = true
    }
    
    @IBAction func highlightsTapped(sender: UIGestureRecognizer) {
        
        if let presenter = presenter as? DashboardPresenter,
            let viewModel = presenter.expandCollapseTopHighlights() {
            
            self.highlights.updateSectionView(with: viewModel)
        }
    }
    
    // MARK Managing transitions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "LastPaymentsSegue",
            let lastPaymentsViewController = segue.destination as? LastPaymentsViewController {
            
            lastPaymentsViewController.presenter = presenter
            if let presenter = presenter as? DashboardPresenter {
                lastPaymentsViewController.eventEmitter = presenter.eventEmitter
            }
        }
    }
}




