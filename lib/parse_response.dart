import 'package:eventify/eventify.dart';
import 'package:flutter_razorpay/error_codes.dart';
import 'package:flutter_razorpay/event_names.dart';
import 'package:flutter_razorpay/payment/payment_data.dart';
import 'package:flutter_razorpay/payment/payment_failure.dart';

void parseResponse(Map<dynamic, dynamic> response, EventEmitter emitter) {
  print(response);
  String event = response['status'];
  var data;
  switch (event) {
    case RazorpayEvent.ON_PAYMENT_SUCCESS:
    case RazorpayEvent.ON_EXTERNAL_WALLET_SELECTED:
      data = PaymentData.fromMap(response['data']);
      break;

    case RazorpayEvent.ON_PAYMENT_ERROR:
      data = PaymentFailure.fromMap(response['data']);
      break;

    default:
      data = PaymentFailure(RazorpayErrorCode.UNKNOWN_ERROR, "Unknown Error");
      break;
  }
  emitter.emit(event, null, data);
}
