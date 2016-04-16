//
//  PayViewModel.swift
//  storeApp
//
//  Created by Remi Robert on 16/04/16.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

import UIKit
import RxSwift
import NSObject_Rx

enum PaymentStatus {
    case Received
    case Canceled
    case Successed
}

class PayViewModel: NSObject {

    private var voiceSendRecognizer = VoiceSendRecognizer()
    private var voiceListenRecognizer = VoiceListenRecognizer()
    private var amount: Double!
    private var completionHandler:(PaymentStatus -> Void)!
    
    func sendBackResponse() {
        self.voiceSendRecognizer.startPlay("\(Int(self.amount!) * 100)") {
            self.receivePayment()
        }
    }
    
    func receivePayment() {
        self.voiceListenRecognizer.startRecord { (string: String?) in
            if string == "WTP" {
                self.completionHandler(.Received)
                dispatch_async(dispatch_get_main_queue(), {
                    let _ = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(PayViewModel.sendBackResponse), userInfo: nil, repeats: false)
                })
            }
            else if string == "OKC" {
                self.completionHandler(.Successed)
            }
            else if string == "BNE" {
                self.completionHandler(.Canceled)
            }
        }
    }
    
    func makeTransaction(amount: Double) -> Observable<PaymentStatus> {
        self.amount = amount
        
        return Observable.create({ observer in
            self.completionHandler = { success in
                observer.onNext(success)
            }
            self.receivePayment()
            return NopDisposable.instance
        })
    }
}
