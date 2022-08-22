import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("About Us",
              style: const TextStyle(
                  color: MakeMyTripColors.colorBlack,
                  fontWeight: FontWeight.bold)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 15.0, left: 30, right: 20, bottom: 20),
            child: Column(
              children: [
                40.verticalSpace,
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 16),
                  child: Image.asset('assets/img/logot.png'),
                ),
                const Text('About Us', style: AppTextStyles.labelNameTextStyle),
                30.verticalSpace,
                const Text(
                  'Travelsy is one-stop solution for all your travel needs. Travelsy provides us time-saving value added services along with'
                  '24/7 accessibility and technical support. You are just a few clicks away from booking your choice hotel. You can book hotel all over India from '
                  'anywhere just by using our app.',
                  textAlign: TextAlign.justify,
                ),
                10.verticalSpace,
                const Text(
                  'Our goal is to provide one-stop solution regarding travel booking.We aim to provide the best possible user experience across their travel journey'
                  'which includes effective planning, resources, superior booking experience and 24/7 live customer support.',
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ),
        ));
  }
}
