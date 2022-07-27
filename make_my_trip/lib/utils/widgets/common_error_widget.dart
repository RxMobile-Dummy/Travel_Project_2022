import 'package:flutter/material.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

import '../../../../core/theme/make_my_trip_colors.dart';

class CommonErrorWidget extends StatelessWidget {
  const CommonErrorWidget({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.statusCode,
  }) : super(key: key);

  final String imagePath;
  final String title;
  final String statusCode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(),
        AspectRatio(
          aspectRatio: 1.6,
          child: Image.asset(
            imagePath,
          ),
        ),
        30.verticalSpace,
        Text(
          statusCode,
          style: const TextStyle(
              color: MakeMyTripColors.accentColor,
              fontSize: 50,
              fontWeight: FontWeight.bold),
        ),
        25.verticalSpace,
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: MakeMyTripColors.accentColor,
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        const Spacer(),
      ],
    );
  }
}
