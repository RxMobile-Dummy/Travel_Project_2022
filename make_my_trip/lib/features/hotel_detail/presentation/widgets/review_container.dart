import 'package:flutter/material.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

import '../../../../core/theme/make_my_trip_colors.dart';

class ReviewContainer extends StatelessWidget {
  const ReviewContainer({
    Key? key,
    this.icon,
    required this.leadingText,
    required this.tralingText,
    required this.onTap,
  }) : super(key: key);

  final IconData? icon;
  final String leadingText, tralingText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
            color: MakeMyTripColors.color50gray.withOpacity(.3),
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            (icon == null)
                ? const SizedBox()
                : const Icon(
                    Icons.star_rounded,
                    color: MakeMyTripColors.accentColor,
                  ),
            8.horizontalSpace,
            Text(
              leadingText,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: (icon != null)
                      ? MakeMyTripColors.colorBlack
                      : MakeMyTripColors.color70gray),
            ),
            const Spacer(),
            Text(
              tralingText,
              style: const TextStyle(
                  fontSize: 16, color: MakeMyTripColors.color50gray),
            ),
            const Icon(Icons.arrow_forward_ios_rounded,
                color: MakeMyTripColors.color50gray),
          ],
        ),
      ),
    );
  }
}
