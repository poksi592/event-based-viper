//
//  DashboardAnalytics.swift
//  EventEmitterDemo
//
//  Created by Mladen Despotovic on 28.08.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import Foundation

/**
 This class translates the internal module event and their eventual payload into
 payload, which is understood by Analytics Module by convention.
 This way the complexity of forming precise Analytics payload is removed from distributed
 Event Creator objects and concentrated into this one.
 */
class DashboardAnalytics: EventEmitting {

    // MARK: EventEmitting
    typealias EventEmitter = DashboardEventEmitter
    var eventEmitter: DashboardEventEmitter? = nil
    //
    
    private struct Analytics {
        
        static let paymentRefundRequested = "paymentRefundRequested"
        static let topHighlightsExpanded = "topHighlightsExpanded"
        static let paymentDetailOpen = "paymentDetailOpen"
    }
    
    private(set) var callback: ModuleCallback?
    
    init(callback: ModuleCallback?, eventEmitter: DashboardEventEmitter?) {
        self.callback = callback
        self.eventEmitter = eventEmitter
        subscribeToEvents()
    }
    
    // MARK: EventEmitting Subscribing to events
    func subscribeToEvents() {
        
        eventEmitter?.subscribe { [weak self] (payload) in
            
            self?.parse(payload: payload)
        }
    }
    
    // Parsing and handling analytical event, in our case firing structured payload back to
    // ModuleCallback, where app logic will pick it up and send to AnalyticsModule
    func parse(payload: [String: Any]) {
        
        guard let analytics = payload["analytics"] as? [String: Any] else { return }
        
        var callbackPayload = [String: Any]()
        var analyticsPayload = [String: Any]()
        
        // Adding "refundTapped" event to analytics payload with the payment ID
        analyticsPayload[Analytics.paymentRefundRequested] = analytics[DashboardEvent.refundTapped.rawValue]
        
        // Adding "topHighlightsExpanded" event to analytics payload, no parameters needed
        if analytics[DashboardEvent.expandTopHighlights.rawValue] != nil {
            analyticsPayload[Analytics.topHighlightsExpanded] = ""
        }
        
        // Adding "paymentDetailOpen" event to analytics payload with the payment ID
        if analytics[DashboardEvent.paymentDetailOpen.rawValue] != nil {
            analyticsPayload[Analytics.paymentDetailOpen] = analytics[DashboardEvent.paymentDetailOpen.rawValue]
        }
        
        // Putting all analytics together
        callbackPayload["analytics"] = analyticsPayload
        callback?(callbackPayload, nil, nil, nil)
    }
}
