//
//  PaymentsViewController.swift
//  ModuleArchitectureDemo
//
//  Created by Mladen Despotovic on 22/05/2018.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import Foundation
import UIKit

class PaymentsViewController: UITableViewController, RoutableViewControllerType {

    var presenter: ModulePresentable?
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var payButton: UIButton!
    
    @IBAction private func payButtonAction(_ sender: UIButton) {
        
        if let presenter = presenter as? PaymentsPresenter {
            presenter.pay(amount: amountTextField.text)
        }
    }
}
