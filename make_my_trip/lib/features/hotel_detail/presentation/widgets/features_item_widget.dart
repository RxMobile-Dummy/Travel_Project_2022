import 'package:flutter/material.dart';

class FeaturesItemWidget extends StatelessWidget {
  const FeaturesItemWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: .5,
      child: Row(
        children: [
          const Icon(
            Icons.star_rounded,
            color: Colors.grey,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            text,
            style: const TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
