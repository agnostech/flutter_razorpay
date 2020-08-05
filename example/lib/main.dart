import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_razorpay/flutter_razorpay.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() {

    FlutterRazorpay.on(RazorpayEvent.ON_PAYMENT_SUCCESS, (PaymentData data) {
      setState(() {
        _platformVersion = data.toString();
      });
    });

    FlutterRazorpay.on(RazorpayEvent.ON_PAYMENT_ERROR, (PaymentFailure data) {
      setState(() {
        _platformVersion = data.toString();
      });
    });

    FlutterRazorpay.on(RazorpayEvent.ON_EXTERNAL_WALLET_SELECTED, (PaymentData data) {
      setState(() {
        _platformVersion = data.toString();
      });
    });
    // Platform messages may fail, so we use a try/catch PlatformException.
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Text(
              _platformVersion
            ),
            SizedBox(
              height: 24,
            ),
            RaisedButton(
              child: Text(
                'start payment'
              ),
              onPressed: () {
                try {
                  Map<String, Object> data = Map<String, Object>();
                  data["amount"] = 9900;
                  data["currency"] = "INR";
                  data["name"] = "Tatva Moksha lakshya";
                  FlutterRazorpay.openCheckout("rzp_test_Bl4GTQ6hfMsEad", data);
                } on PlatformException catch (e) {
                  print(e);
                  setState(() {
                    _platformVersion = e.toString();
                  });
                }
              },
            )
          ],
        )
      ),
    );
  }
}
