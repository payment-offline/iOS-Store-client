//
//  PayViewController.swift
//  storeApp
//
//  Created by Remi Robert on 16/04/16.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

import UIKit

class PayViewController: UIViewController {

    var viewModel = PayViewModel()
    
    override func viewDidAppear(animated: Bool) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.receivePayment()
    }
}
