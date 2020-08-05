class PaymentData {
  final String paymentId;
  final String orderId;
  final String signature;
  final String walletName;

  PaymentData(this.paymentId, this.orderId, this.signature, this.walletName);

  static PaymentData fromMap(Map<dynamic, dynamic> data) {
    String paymentId = data['paymentId'];
    String orderId = data['orderId'];
    String signature = data['signature'];
    String walletName = data['walletName'];

    return PaymentData(paymentId, orderId, signature, walletName);
  }

  @override
  String toString() {
    return "PaymentData: paymentId=$paymentId, orderId=$orderId, signature=$signature, walletName=$walletName";
  }
}
