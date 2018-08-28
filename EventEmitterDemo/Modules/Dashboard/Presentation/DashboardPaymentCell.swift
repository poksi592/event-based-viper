//
//  DashboardPaymentCell.swift
//  EventEmitterDemo
//
//  Created by Mladen Despotovic on 02.08.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import Foundation
import UIKit

class DashboardPaymentCell: UITableViewCell, EventEmitting {
    
    // MARK: EventEmitting
    typealias EventEmitter = DashboardEventEmitter
    var eventEmitter: DashboardEventEmitter? = nil
    //
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var recipient: UILabel!
    @IBOutlet weak var amount: UILabel!
    var id: String?
    
    @IBAction func refundButtonTapped(sender: UIButton) {
        
        eventEmitter?.notify(eventPayload: [DashboardEvent.refundTapped.rawValue: id ?? "",
                                            "analytics": [DashboardEvent.refundTapped.rawValue: id ?? ""]])
    }
}
