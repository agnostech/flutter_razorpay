//
//  RazorpayMethodChannelHandler.swift
//  flutter_razorpay
//
//  Created by Vishal Dubey on 05/08/20.
//

import Flutter

private var razorpayDelegate: SwiftFlutterRazorpay = SwiftFlutterRazorpay()

func handleMethodCall(call: FlutterMethodCall, result: @escaping FlutterResult) {
   
    guard let arguments = call.arguments as? [String : Any?] else {
        result(FlutterError(code: "NO_ARGUMENTS_PROVIDED", message: "No arguments were provided. If this call uses no arguments, provide an empty Map<String, Object>.", details: nil))
        return
    }
    
    switch call.method {
    case "openCheckout":
        razorpayDelegate.openCheckout(data: arguments, result: result)
        break;
    case "sync":
        razorpayDelegate.sync(result: result)
        break;
    default:
        result(FlutterMethodNotImplemented)
    }
}
