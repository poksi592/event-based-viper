//
//  UIViewExtensions.swift
//  EventEmitterDemo
//
//  Created by Mladen Despotovic on 31.07.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    static func instantiateFromNib() -> UIView {

        let nib = UINib(nibName: String(describing: self), bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
}

