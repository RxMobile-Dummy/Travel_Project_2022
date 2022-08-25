import 'package:flutter/material.dart';

import '../../core/theme/make_my_trip_colors.dart';

class CommonSecondaryButton extends StatelessWidget {
  const CommonSecondaryButton(
      {Key? key, required this.text, required this.onTap})
      : super(key: key);
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(
        text,
        style:
            const TextStyle(fontSize: 18, color: MakeMyTripColors.accentColor),
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 8),
        primary: MakeMyTripColors.colorWhite,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(
                color: MakeMyTripColors.accentColor, width: 1)),
      ),
    );
  }
}
