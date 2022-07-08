import 'package:flutter/material.dart';

import '../../../../core/theme/make_my_trip_colors.dart';

class Intro extends StatelessWidget {
  Intro(
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imagepath,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            title.toUpperCase(),
            style: const TextStyle(
                color: MakeMyTripColors.colorBlack,
                fontSize: 26,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            subtitle,
            style: const TextStyle(
                color: MakeMyTripColors.colorBlack, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
