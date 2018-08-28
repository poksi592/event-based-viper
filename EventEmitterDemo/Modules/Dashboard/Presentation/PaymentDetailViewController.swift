//
//  PaymentDetailViewController.swift
//  EventEmitterDemo
//
//  Created by Mladen Despotovic on 03.08.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import Foundation
import UIKit

class PaymentDetailViewController: UIViewController, RoutableViewControllerType, EventEmitting {
    
    @IBOutlet var id: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var amount: UILabel!
    @IBOutlet var accountNo: UILabel!
    @IBOutlet var recipientAccountNo: UILabel!
    @IBOutlet var recipientName: UILabel!
    @IBOutlet var text: UILabel!
    
    // MARK: EventEmitting
    typealias EventEmitter = DashboardEventEmitter
    var eventEmitter: DashboardEventEmitter? = nil
    //
    
    weak var presenter: ModulePresentable?
    private weak var dashboardPresenter: DashboardPresenter?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        dashboardPresenter = presenter as? DashboardPresenter
       // setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        dashboardPresenter = presenter as? DashboardPresenter
        setup()
        super.viewWillAppear(animated)
    }
    
    func setup() {
        
        if let index = dashboardPresenter?.lastSelectedPayment,
            let viewModel = dashboardPresenter?.dashboardPaymentViewModels?[index] {
            
            id.text = viewModel.id
            date.text = viewModel.date
            amount.text = viewModel.amount
            accountNo.text = viewModel.accountNo
            recipientAccountNo.text = viewModel.recipientAccountNo
            recipientName.text = viewModel.recipientName
            text.text = viewModel.description
        
            // Event Emitting
            eventEmitter?.notify(eventPayload: ["analytics": [DashboardEvent.paymentDetailOpen.rawValue: viewModel.id]])
        }
    }
    
}
