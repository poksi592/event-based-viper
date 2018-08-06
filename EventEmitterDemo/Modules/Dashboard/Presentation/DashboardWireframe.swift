//
//  DashboardWireframe.swift
//  EventEmitterDemo
//
//  Created by Mladen Despotovic on 27.07.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import Foundation
import UIKit

class DashboardWireframe: WireframeType {

    lazy var storyboard: UIStoryboard = UIStoryboard(name: "DashboardStoryboard", bundle: nil)
    var presentedViewControllers = [WeakContainer<UIViewController>]()
    var presentationMode: ModulePresentationMode = .none
}
