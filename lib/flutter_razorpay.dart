import 'dart:async';

import 'package:flutter/services.dart';

class FlutterRazorpay {
  static const MethodChannel _channel =
      const MethodChannel('in.agnostech.flutterrazorpay/flutter_razorpay');

  static Future<T> _invokeMethod<T>(
    String method, {
    Map<String, Object> arguments = const {},
  }) {
    return _channel.invokeMethod(method, arguments);
  }

  static Future<bool> openCheckout() async {
    try {
      final bool isOpened =
      await _invokeMethod('openCheckout');
      return isOpened;
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }
}
