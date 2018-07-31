//
//  DashboardModule.swift
//  EventEmitterDemo
//
//  Created by Mladen Despotovic on 27.07.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import Foundation

class DashboardModule: ModuleType {
    
    var route: String = {
        return "dashboard"
    }()
    
    var paths: [String] = {
        return ["/present"]
    }()
    
    var subscribedRoutables: [ModuleRoutable.Type] = [DashboardPresenter.self]
    var instantiatedRoutables: [WeakContainer<ModuleRoutable>] = []
}
