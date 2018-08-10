//
//  LastPaymentsViewController.swift
//  EventEmitterDemo
//
//  Created by Mladen Despotovic on 27.07.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import Foundation
import UIKit

class LastPaymentsViewController: UITableViewController, RoutableViewControllerType {
    
    weak var presenter: ModulePresentable?
    private weak var dashboardPresenter: DashboardPresenter?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        dashboardPresenter = presenter as? DashboardPresenter
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        
        self.tableView.register(UINib(
            nibName: "DashboardPaymentCell",
            bundle: nil).self, forCellReuseIdentifier: "DashboardPaymentCell")

        dashboardPresenter?.getLastPayments { [weak self] in
                
            self?.tableView.reloadData()
        }
    }
    
    // MARK: UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dashboardPresenter?.dashboardPaymentViewModels?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardPaymentCell", for: indexPath) as! DashboardPaymentCell
        if let viewModel = dashboardPresenter?.dashboardPaymentViewModels?[indexPath.row] {
            cell.date.text = viewModel.date
            cell.recipient.text = viewModel.recipientName
            cell.amount.text = viewModel.amount
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        dashboardPresenter?.selectedPayment(index: indexPath.row)
    }
}
