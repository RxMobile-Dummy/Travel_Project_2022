import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

class ViewFullCoupon extends StatelessWidget {
  String imgUrl;
  String discountText;
  String couponTitle;
  String couponCode;
  String expiryDate;
  var couponDetails;

  ViewFullCoupon(
      {Key? key,
      required this.discountText,
      required this.imgUrl,
      required this.expiryDate,
      required this.couponTitle,
      required this.couponCode,
      required this.couponDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange[100],
        appBar: AppBar(
          title: Text('View Coupon '),
        ),
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            80.verticalSpace,
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: Image.network('$imgUrl',
                    width: 250, height: 250, fit: BoxFit.fill),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                '$discountText% OFF',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                couponTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Copy code and use at checkout ',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                  onTap: () {},
                  child: Container(
                      decoration: BoxDecoration(color: Colors.white),
                      child: SelectableText(
                        couponCode,
                        style: const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Expiry Date : $expiryDate',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 4),
              child: Text(
                'Details',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Html(
              data: "$couponDetails",
            ),
          ],
        )));
  }
}
