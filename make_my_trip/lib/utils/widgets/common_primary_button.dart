import 'package:flutter/material.dart';

import '../../core/theme/make_my_trip_colors.dart';

class CommonPrimaryButton extends StatelessWidget {
  const CommonPrimaryButton(
      {Key? key, required this.text, this.disable, required this.onTap})
      : super(key: key);
  final String text;
  final bool? disable;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(
        text,
        style: const TextStyle(fontSize: 18),
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        primary: (disable ?? false)
            ? MakeMyTripColors.color30gray
            : MakeMyTripColors.accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
