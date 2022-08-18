import 'package:flutter/material.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

class CouponWidget extends StatelessWidget {
  String imgUrl;
  String discountText;
  String couponTitle;
  String expiryDate;

  CouponWidget(
      {Key? key,
      required this.couponTitle,
      required this.discountText,
      required this.expiryDate,
      required this.imgUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              Colors.orangeAccent,
              Colors.yellow.shade300,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: Image.network(imgUrl,
                    width: 90, height: 90, fit: BoxFit.fill),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: VerticalDivider(
                thickness: 3,
                color: Colors.blue[900],
              ),
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.verticalSpace,
                Text(
                  '$discountText% OFF',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900]),
                ),
                Text(
                  '$couponTitle',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Text('Expires at ',
                    style: TextStyle(fontSize: 14, color: Colors.redAccent)),
                Text('$expiryDate',
                    style: TextStyle(fontSize: 14, color: Colors.redAccent)),
                25.verticalSpace,
                Row(
                  children: [
                    60.horizontalSpace,
                    Text(
                      '*terms & conditions applied   ',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green[900],
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
