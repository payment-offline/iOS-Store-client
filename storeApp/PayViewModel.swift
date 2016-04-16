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

class PayViewModel: NSObject {

    private var voiceSendRecognizer = VoiceSendRecognizer()
    private var voiceListenRecognizer = VoiceListenRecognizer()
    
//    private func sendString(string: String) -> Observable<Void> {
//        print("------ send")
//        return Observable.create({ observer in
//            self.voiceSendRecognizer.startPlay(string, completion: {
//                return observer.onNext()
//            })
//            return AnonymousDisposable {
//                self.voiceSendRecognizer.stopPlay()
//            }
//        })
//    }
//    
//    private func receiveString() -> Observable<String?> {
//        print("------ receive")
//        return Observable.create({ observer in
//            self.voiceListenRecognizer.startRecord({ string in
//                observer.onNext(string)
//            })
//            return AnonymousDisposable {
//                self.voiceListenRecognizer.stopRecord()
//            }
//        })
//    }
    
    func sendBackResponse() {
        print("send back response now")
        self.voiceSendRecognizer.startPlay("10") {
            print("send message")
            self.receivePayment()
        }
//        self.sendString("amount\(self.item.price)").subscribe().addDisposableTo(self.rx_disposeBag)
    }
    
    func receivePayment() {
        print("receive payment")
        
        self.voiceListenRecognizer.startRecord { (string: String?) in
            print("string : \(string)")
            self.voiceListenRecognizer.stopRecord()
            if string == "WTP" {
                dispatch_async(dispatch_get_main_queue(), {
                    let _ = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(PayViewModel.sendBackResponse), userInfo: nil, repeats: false)
                })
            }
        }
    
//        self.receiveString().subscribeNext { string in
//            print("string received : \(string)")
//            
//            self.voiceListenRecognizer.stopRecord()
//            dispatch_async(dispatch_get_main_queue(), { 
//                let _ = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(PayViewModel.sendBackResponse), userInfo: nil, repeats: false)
//            })
//        }.addDisposableTo(rx_disposeBag)
        
//        self.receiveString().flatMap { (text: String?) -> Observable<Bool> in
//            print("string : \(text)")
//            guard let text = text else {
//                return Observable.just(false)
//            }
//            print("OK payment !")
//            return Observable.just(true)
//        }.subscribeNext { success in
//            if (success) {
//                self.voiceListenRecognizer.stopRecord()
//                self.performSelector(#selector(PayViewModel.sendBackResponse), withObject: nil, afterDelay: 1)
////                Observable<Int>.timer(0, period: 1, scheduler: MainScheduler.instance).flatMap({ (_: Int) -> Observable<Void> in
////                    return self.sendString("amount\(self.item.price)")
////                }).subscribe().addDisposableTo(self.rx_disposeBag)
//            }
//        }.addDisposableTo(rx_disposeBag)
    }
}
