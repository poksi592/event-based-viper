//
//  DashboardPresenter.swift
//  EventEmitterDemo
//
//  Created by Mladen Despotovic on 27.07.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import Foundation

class DashboardPresenter: ModuleRoutable, ModulePresentable, EventEmitting {
    
    // MARK: EventEmitting
    typealias EventEmitter = DashboardEventEmitter
    var eventEmitter: DashboardEventEmitter? = DashboardEventEmitter()
    //
    
    // MARK: EventEmitting Subscribing to events
    func subscribeToEvents() {
        
        eventEmitter?.subscribe { [weak self] (payload) in
            
            let refundTappedPayload = payload.filter { $0.key == DashboardEvent.refundTapped.rawValue }
            if refundTappedPayload.isEmpty == false {
                self?.callback?(refundTappedPayload, nil, nil, nil)
            }
        }
    }
    
    required init() {
        subscribeToEvents()
    }
    
    var wireframe: WireframeType = DashboardWireframe()
    var interactor = DashboardInteractor()
    private(set) var dashboardAnalytics: DashboardAnalytics?
    private(set) var parameters: ModuleParameters?
    private(set) var callback: ModuleCallback?
    
    private(set) var topHighlightsSectionViewModel: TopHighlightsSectionViewModel?
    var dashboardPaymentViewModels: [DashboardPaymentViewModel]?
    private(set) var lastSelectedPayment: Int?
    
    static func routable() -> ModuleRoutable {
        return self.init()
    }
    
    static func getPaths() -> [String] {
        return ["/present"]
    }
    
    func route(parameters: ModuleParameters?, path: String?, callback: ModuleCallback?) {
        
        self.parameters = parameters
        self.callback = callback
        self.dashboardAnalytics = DashboardAnalytics(callback: callback, eventEmitter: eventEmitter)
        
        if path == "/present" {
            let _ = wireframe.presentViewController(ofType: DashboardViewController.self,
                                                    presenter: self,
                                                    parameters: parameters)
        }
    }
    
    // MARK: Highlights
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
    
    // MARK: Last payments
    
    func getLastPayments(completion: @escaping () -> Void) {
        
        interactor.getLast10Payments { [weak self]  (payments, error) in
            
            // We shall not tackle error handling here
            self?.dashboardPaymentViewModels = payments?.compactMap { DashboardPaymentViewModel(model: $0) }
            completion()
        }
    }
    
    func selectedPayment(index: Int) -> PaymentDetailViewController?  {

        lastSelectedPayment = index
        let viewController = wireframe.presentViewController(ofType: PaymentDetailViewController.self,
                                                             presenter: self,
                                                             parameters: ["presentationMode": "navigationStack",
                                                                          "viewController": "PaymentDetailViewControllerId"]) as? PaymentDetailViewController
        viewController?.eventEmitter = eventEmitter
        return viewController
    }
}
