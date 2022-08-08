import 'dart:convert';

/// order_id : "order_K39onLudzIBX4Q"
/// currency : "INR"
/// amount : 500.05

PaymentModel paymentModelFromJson(String str) =>
    PaymentModel.fromJson(json.decode(str));
String paymentModelToJson(PaymentModel data) => json.encode(data.toJson());

class PaymentModel {
  PaymentModel({
    this.orderId,
    this.currency,
    this.amount,
  });

  PaymentModel.fromJson(dynamic json) {
    orderId = json['order_id'];
    currency = json['currency'];
    amount = json['amount'].toDouble();
  }
  String? orderId;
  String? currency;
  double? amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_id'] = orderId;
    map['currency'] = currency;
    map['amount'] = amount;
    return map;
  }
}
