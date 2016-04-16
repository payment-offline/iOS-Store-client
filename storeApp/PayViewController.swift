//
//  PayViewController.swift
//  storeApp
//
//  Created by Remi Robert on 16/04/16.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PayViewController: UIViewController {
    
    var viewModel = PayViewModel()
    
    @IBOutlet weak var payButton: UIButton!
    
    override func viewDidLayoutSubviews() {
        self.payButton.layer.cornerRadius = self.payButton.frame.size.width / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.payButton.rx_tap.flatMap { (_: ()) -> Observable<Double?> in
            return PromptAlert.show(self, title: "Choose an amount")
            }.subscribeNext { amount in
                guard let amount = amount else {
                    return
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self.payButton.hidden = true
                })
                self.viewModel.makeTransaction(amount).subscribeNext({ success in
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        switch success {
                        case .Successed:
                            self.displayState("✅ Payment successed")
                        case .Received:
                            self.displayState("Received payment")
                        case .Canceled:
                            self.displayState("❌ Payment Failed")
                        }
                    })
                    
                }).addDisposableTo(self.rx_disposeBag)
            }.addDisposableTo(rx_disposeBag)
    }
}

extension PayViewController {
    
    func displayState(title: String) {
        self.payButton.hidden = false
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .Alert)
        
        alertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (_) in }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}
