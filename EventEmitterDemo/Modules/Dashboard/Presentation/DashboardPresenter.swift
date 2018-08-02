//
//  DashboardPresenter.swift
//  EventEmitterDemo
//
//  Created by Mladen Despotovic on 27.07.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import Foundation

class DashboardPresenter: ModuleRoutable {
    
    lazy private var wireframe = DashboardWireframe()
    lazy private var interactor = DashboardInteractor()
    private var parameters: ModuleParameters?
    private var callback: ModuleCallback?
    
    var topHighlightsSectionViewModel: TopHighlightsSectionViewModel?
    
    static func routable() -> ModuleRoutable {
        return self.init()
    }
    
    static func getPaths() -> [String] {
        return ["/present"]
    }
    
    func route(parameters: ModuleParameters?, path: String?, callback: ModuleCallback?) {
        
        self.parameters = parameters
        self.callback = callback
        
        if path == "/present" {
            wireframe.presentDashboardViewController(with: self,
                                                     parameters: parameters)
        }
    }
    
    func getHighlights(completion: @escaping (TopHighlightsSectionViewModel?) -> Void) {

        interactor.getTopHighlights { [weak self] (topHighlights, error) in

            // We shall not tackle error handling here
            let topHighlightsViewModels = topHighlights?.compactMap { TopHighlightViewModel(model: $0) }
            if let topHighlightsViewModels = topHighlightsViewModels {
                
                self?.topHighlightsSectionViewModel = TopHighlightsSectionViewModel(topHighlightViewModels: topHighlightsViewModels)
                completion(self?.topHighlightsSectionViewModel)
            }
        }
    }
    
    func expandCollapseTopHighlights() -> TopHighlightsSectionViewModel? {
        
        guard let viewModel = topHighlightsSectionViewModel else { return nil }
        viewModel.isExpanded = !viewModel.isExpanded
        return viewModel
    }
}
