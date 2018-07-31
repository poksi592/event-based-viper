//
//  TopHighlightView.swift
//  EventEmitterDemo
//
//  Created by Mladen Despotovic on 30.07.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import Foundation
import UIKit

class TopHighlightView: UIView {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet var from: UILabel!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var transactionAmount: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet var textHeightConstraint: NSLayoutConstraint!
    @IBOutlet var fromHeightConstraint: NSLayoutConstraint!
    
    func setup(with viewModel: TopHighlightViewModel) {
        
        title.text = viewModel.title
        from.text = viewModel.from
        text.text = viewModel.text
        transactionAmount.text = viewModel.amount
        if let imagePath = viewModel.imagePath {
            icon.image = UIImage(named: imagePath)
        }
        else {
            icon.isHidden = true
        }
        
        from.isHidden = true
        text.isHidden = true
    }
}
