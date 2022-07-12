import 'package:flutter/material.dart';

class LocationViewWidet extends StatelessWidget {
  const LocationViewWidet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.4),
          borderRadius: BorderRadius.circular(8)),
    );
  }
}
