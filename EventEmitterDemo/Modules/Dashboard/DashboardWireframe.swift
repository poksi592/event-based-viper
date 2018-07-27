//
//  DashboardWireframe.swift
//  EventEmitterDemo
//
//  Created by Mladen Despotovic on 27.07.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import Foundation
import UIKit

class DashboardWireframe: WireframeType {
   
    lazy var storyboard: UIStoryboard = UIStoryboard(name: "DashboardStoryboard", bundle: nil)
    var presentedViewControllers = [WeakContainer<UIViewController>]()
    var presentationMode: ModulePresentationMode = .none
    
    func presentDashboardViewController(with presenter: DashboardPresenter,
                                        parameters: ModuleParameters?) {
        
        setPresentationMode(from: parameters)
        if let viewController = viewController(from: parameters) {
            
            present(viewController: viewController)
            guard let dashboardViewController = viewController as? DashboardViewController else { return }
            dashboardViewController.presenter = presenter
        }
    }
}
