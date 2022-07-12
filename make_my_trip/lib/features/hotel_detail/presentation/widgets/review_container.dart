import 'package:flutter/material.dart';

class ReviewContainer extends StatelessWidget {
  const ReviewContainer({
    Key? key,
    this.icon,
    required this.leadingText,
    required this.tralingText,
  }) : super(key: key);

  final IconData? icon;
  final String leadingText, tralingText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.2),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          (icon == null)
              ? const SizedBox()
              : const Icon(
                  Icons.star_rounded,
                  color: Colors.blue,
                ),
          const SizedBox(
            width: 8,
          ),
          Text(
            leadingText,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: (icon != null) ? Colors.black : Colors.grey),
          ),
          const Spacer(),
          Text(
            tralingText,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey),
        ],
      ),
    );
  }
}
