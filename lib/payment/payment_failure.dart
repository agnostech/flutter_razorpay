class PaymentFailure {
  final int code;
  final String message;

  PaymentFailure(this.code, this.message);

  static PaymentFailure fromMap(Map<dynamic, dynamic> data) {
    int code = data['code'];
    String message = data['message'];

    return PaymentFailure(code, message);
  }

  @override
  String toString() {
    return "PaymentFailure: code: $code, message=$message";
  }
}
