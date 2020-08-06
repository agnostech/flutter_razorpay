import 'dart:async';

import 'package:eventify/eventify.dart';
import 'package:flutter/services.dart';
import 'package:flutter_razorpay/parse_response.dart';

export 'package:flutter_razorpay/error_codes.dart';
export 'package:flutter_razorpay/event_names.dart';
export 'package:flutter_razorpay/payment/payment_data.dart';
export 'package:flutter_razorpay/payment/payment_failure.dart';

class FlutterRazorpay {
  static const MethodChannel _channel =
      const MethodChannel('in.agnostech.flutterrazorpay/flutter_razorpay');

  static final EventEmitter _emitter = EventEmitter();

  static Future<T> _invokeMethod<T>(
    String method, {
    Map<String, Object> arguments = const {},
  }) {
    return _channel.invokeMethod(method, arguments);
  }

  static void _sync() async {
    final Map<dynamic, dynamic> response = await _invokeMethod('sync');
    if (response != null) {
      _sendEventResult(response);
    }
  }

  static void _sendEventResult(Map<dynamic, dynamic> response) {
    parseResponse(response, _emitter);
  }

  static void openCheckout(String apiKeyId, Map<String, Object> data) async {
    if (apiKeyId == null) {
      return Future.error(
          "API Key ID is required. Pass the exisiting API Key ID or generate a new API key from the Razorpay dashboard.");
    }
    data['key'] = apiKeyId;

    if (!data.containsKey("amount")) {
      return Future.error('amount is a required field in the data map');
    }

    if (!data.containsKey("currency")) {
      return Future.error('currency is a required field in the data map');
    }

    if (!data.containsKey("name")) {
      return Future.error("name is a required field in the data map");
    }

    try {
      final Map<dynamic, dynamic> response =
          await _invokeMethod('openCheckout', arguments: data);
      _sendEventResult(response);
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  static void on(String eventName, Function handler) {
    EventCallback callback = (event, context) {
      handler(event.eventData);
    };
    _emitter.on(eventName, null, callback);
    _sync();
  }

  static void clear() {
    _emitter.clear();
  }
}
