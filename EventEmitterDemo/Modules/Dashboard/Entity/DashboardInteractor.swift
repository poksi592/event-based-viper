//
//  DashboardInteractor.swift
//  EventEmitterDemo
//
//  Created by Mladen Despotovic on 27.07.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import Foundation

class DashboardInteractor {
    
    func getLast10Payments(completion: @escaping ([DashboardPayment]?, Error?) -> Void) {
        
        let service = MockDashboardNetworkService()
        service.get(host: "dashboard", path: "/last-10-payments") { (response, urlResponse, error) in
            
            guard let responseDict = response?["response"] as? [Any] else {
                
                completion(nil, error)
                return
            }
                        
            let payments: [DashboardPayment?] = responseDict.map { (paymentObject) in
                
                guard let dataObject = try? JSONSerialization.data(withJSONObject: paymentObject,
                                                                   options: .prettyPrinted),
                    let payment = try? JSONDecoder().decode(DashboardPayment.self, from: dataObject) else {
                        return nil
                }
                return payment
            }
            completion(payments.compactMap { $0 }, nil)
        }
    }
    
    func getTopHighlights(completion: @escaping ([TopHighlight]?, Error?) -> Void) {
        
        let service = MockDashboardNetworkService()
        service.get(host: "dashboard", path: "/top-highlights") { (response, urlResponse, error) in
            
            guard let responseDict = response?["response"] as? [Any] else {
                
                completion(nil, error)
                return
            }
            
            let topHighlights: [TopHighlight] = responseDict.compactMap { (topHighlightObject) in
                
                guard let dataObject = try? JSONSerialization.data(withJSONObject: topHighlightObject,
                                                                   options: .prettyPrinted),
                    let topHighlight = try? JSONDecoder().decode(TopHighlight.self, from: dataObject) else {
                        return nil
                }
                return topHighlight
            }
            
            completion(topHighlights, nil)
        }
    }
    
}

class MockDashboardNetworkService: NetworkService {
    
    override func get(scheme: String? = nil,
                      host: String,
                      path: String,
                      parameters: [String : Any]? = nil,
                      completion: @escaping ([String : Any]?, HTTPURLResponse?, Error?) -> Void) {
        
        let url = URL(schema: "https",
                      host: host,
                      path: path,
                      parameters: nil)
        
        let urlResponse = HTTPURLResponse(url: url!,
                                          statusCode: 200,
                                          httpVersion: nil,
                                          headerFields: nil)
        
        if path == "/last-10-payments" {
            
            let filePath = Bundle.main.path(forResource: "Payments", ofType: "json")
            let paymentData = try! Data(contentsOf: URL(fileURLWithPath: filePath!))
            let last10Payments = try! JSONSerialization.jsonObject(with: paymentData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
            completion(last10Payments, urlResponse, nil)
        }
        else if path == "/top-highlights" {
            
            let filePath = Bundle.main.path(forResource: "TopHighlights", ofType: "json")
            let highlightsData = try! Data(contentsOf: URL(fileURLWithPath: filePath!))
            let topHighlights = try! JSONSerialization.jsonObject(with: highlightsData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
            completion(topHighlights, urlResponse, nil)
        }
    }
}




