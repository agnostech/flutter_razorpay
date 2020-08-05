import Flutter
import UIKit

public class SwiftFlutterRazorpayPlugin: NSObject, FlutterPlugin {
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    
    let channel = FlutterMethodChannel(name: "in.agnostech.flutterrazorpay/flutter_razorpay", binaryMessenger: registrar.messenger())
    channel.setMethodCallHandler(handleMethodCall)
    
  }
}
