//
//  PaymentDetailViewController.swift
//  EventEmitterDemo
//
//  Created by Mladen Despotovic on 03.08.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import Foundation
import UIKit

class PaymentDetailViewController: UIViewController, RoutableViewControllerType {
    
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var accountNo: UILabel!
    @IBOutlet weak var recipientAccountNo: UILabel!
    @IBOutlet weak var recipientName: UILabel!
    @IBOutlet weak var text: UILabel!
    
    weak var presenter: ModulePresentable?
    private weak var dashboardPresenter: DashboardPresenter?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        dashboardPresenter = presenter as? DashboardPresenter
        setup()
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
        }
    }
    
}
