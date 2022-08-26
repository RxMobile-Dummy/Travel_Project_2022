import 'dart:convert';

/// order_id : "order_K39onLudzIBX4Q"
/// currency : "INR"
/// amount : 500.05

PaymentModel paymentModelFromJson(String str) =>
    PaymentModel.fromJson(json.decode(str));
String paymentModelToJson(PaymentModel data) => json.encode(data.toJson());

class PaymentModel {
  PaymentModel(
      {this.orderId,
      this.currency,
      this.amount,
      this.username,
      this.userEmail,
      this.userNumber});

  PaymentModel.fromJson(dynamic json) {
    orderId = json['order_id'];
    currency = json['currency'];
    amount = json['amount'].toDouble();
    username = json['user_name'];
    userEmail = json['user_email'];
    userNumber = json['user_phone_number'];
  }
  String? orderId;
  String? currency;
  double? amount;
  String? username;
  String? userEmail;
  String? userNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_id'] = orderId;
    map['currency'] = currency;
    map['amount'] = amount;
    map['user_name'] = username;
    map['user_email'] = userEmail;
    map['user_phone_number'] = userNumber;
    return map;
  }
}
