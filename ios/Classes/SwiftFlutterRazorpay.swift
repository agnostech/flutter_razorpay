//
//  SwiftFlutterRazorpay.swift
//  flutter_razorpay
//
//  Created by Vishal Dubey on 05/08/20.
//

import Flutter
import Razorpay

class SwiftFlutterRazorpay: NSObject, RazorpayPaymentCompletionProtocolWithData, ExternalWalletSelectionProtocol {
        
    private var pendingResult: FlutterResult?
    private var pendingReply: [String: Any]?
    
    func openCheckout(data: [String: Any?], result: @escaping FlutterResult) {
        self.pendingResult = result
        
        let key = data["key"] as? String ?? ""
        
        let razorpay = RazorpayCheckout.initWithKey(key, andDelegateWithData: self)
        razorpay.setExternalWalletSelectionDelegate(self)
        
        var options = data
        options["integration"] = "flutter"
        options["FRAMEWORK"] = "flutter"
        
        razorpay.open(options)
    }
    
    func sync(result: @escaping FlutterResult) {
        result(pendingReply)
    }
    
    private func sendResult(data: [String: Any]) {
        if pendingResult != nil {
            pendingResult!(data)
            pendingReply = nil
        } else {
            pendingReply = data
        }
    }
    
    
    func onPaymentError(_ code: Int32, description str: String, andData response: [AnyHashable : Any]?) {
        
        var data = [String: Any]()
        data["status"] = "payment.error"
        data["data"] = [
            "code": code,
            "message": str
        ]
        
        sendResult(data: data)
    }
    
    func onPaymentSuccess(_ payment_id: String, andData response: [AnyHashable : Any]?) {
        
        var data = [String: Any]()
        data["status"] = "payment.success"
        data["data"] = [
            "orderId": response?["razorpay_order_id"],
            "paymentId": response?["razorpay_payment_id"],
            "signature": response?["razorpay_signature"]
        ]
        
        sendResult(data: data)
    }
    
    func onExternalWalletSelected(_ walletName: String, withPaymentData response: [AnyHashable : Any]?) {
        
        var data = [String: Any]()
        data["status"] = "payment.success"
        data["data"] = [
            "walletName": walletName,
            "orderId": response?["razorpay_order_id"],
            "paymentId": response?["razorpay_payment_id"],
            "signature": response?["razorpay_signature"]
        ]
        
        sendResult(data: data)
    }
    
}
