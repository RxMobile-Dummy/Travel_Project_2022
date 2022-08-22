import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';

class TermsAndPrivacyButton extends StatelessWidget {
  const TermsAndPrivacyButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: GestureDetector(
        child: const Text(
          StringConstants.termsTxt,
          style: TextStyle(color: MakeMyTripColors.accentColor),
        ),
        onTap: () {},
      ),
    );
  }
}
