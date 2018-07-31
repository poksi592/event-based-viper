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
    
    func getHighlights(completion: @escaping ([TopHighlightViewModel]?) -> Void) {
        
        print("gadvaaa")
        interactor.getTopHighlights { (topHighlights, error) in

            // We shall not tackle error handling here
            let topHighlightsViewModels = topHighlights?.compactMap { TopHighlightViewModel(model: $0) }
            completion(topHighlightsViewModels)
        }
    }
}
