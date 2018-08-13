//
//  DashboardEventEmitter.swift
//  EventEmitterDemo
//
//  Created by Mladen Despotovic on 13.08.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import Foundation

enum DashboardEvent: String {
    
    case refundTapped
}

final class DashboardEventEmitter: EventEmitterType {
    
    var eventPayload: [String: Any] = [:]
    var callbacks: [EventCallbackClosure] = []
    var serialQueue = DispatchQueue(label: "DashboardNotifyQueue")
    
    init() {}
}
