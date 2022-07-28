import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({Key? key, required this.onTap}) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: ElevatedButton(
          onPressed: onTap,
          child: Text(
            StringConstants.continueTxt,
            style: AppTextStyles.confirmButtonTextStyle,
          ),
          style: ElevatedButton.styleFrom(
            primary: MakeMyTripColors.accentColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // <-- Radius
            ),
          ),
        ),
      ),
    );
  }
}
