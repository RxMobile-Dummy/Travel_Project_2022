import 'package:flutter/material.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

import '../../../../core/theme/make_my_trip_colors.dart';

class IntroWidget extends StatelessWidget {
  const IntroWidget(
      {Key? key,
      required this.imagepath,
      required this.title,
      required this.subtitle})
      : super(key: key);

  final String imagepath;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(),
        AspectRatio(
          aspectRatio: 1.6,
          child: Image.asset(
            imagepath,
          ),
        ),
        const Spacer(),
        Text(
          title.toUpperCase(),
          style: const TextStyle(
              color: MakeMyTripColors.accentColor,
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        12.verticalSpace,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: MakeMyTripColors.colorBlack,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
