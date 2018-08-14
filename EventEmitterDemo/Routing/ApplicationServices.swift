//
//  ApplicationServices.swift
//  ModuleArchitectureDemo
//
//  Created by Mladen Despotovic on 28.06.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import Foundation


class ApplicationServices {
    
    // ApplicationServices is a singleton, because it makes it easier to be accessed from anywhere to access its functions/services
    static let shared = ApplicationServices()
    let appRouter = ApplicationRouter()
    
    func showDashboard() {
        
        var showDashboardUrl: URL? {
            
            guard let moduleUrl = URL(schema: "yourbank",
                                      host: "dashboard",
                                      path: "/present",
                                      parameters:  ["presentationMode": "navigationStack",
                                                    "viewController": "DashboardViewControllerId"]) else { return nil }
            return moduleUrl
        }
        
        if let url = showDashboardUrl {
            appRouter.open(url: url) { (payload, data, urlResponse, error) in
                
                print(payload)
            }
        }
    }
    
    func pay(amount: Double,
             paymentToken: String?,
             completion: @escaping (() -> Void)) {
        
        // MARK Urls to make the logic more readable, not to clog the logic in closures in the service
        func payUrl(amount: Double, paymentToken: String?) -> URL? {
            
            guard let moduleUrl = URL(schema: "yourbank",
                                      host: "payments",
                                      path: "/pay",
                                      parameters: ["amount": String(amount),
                                                   "token": paymentToken ?? "",
                                                   "presentationMode": "navigationStack",
                                                   "viewController": "PaymentsViewControllerId"]) else { return nil }
            return moduleUrl
        }

        guard let paymentUrl = payUrl(amount: amount, paymentToken: paymentToken) else { return }
        appRouter.open(url: paymentUrl) { [weak self] (response, responseData, urlResponse, error) in
            
            completion()
        }
        // MARK Logic - End
    }
}
