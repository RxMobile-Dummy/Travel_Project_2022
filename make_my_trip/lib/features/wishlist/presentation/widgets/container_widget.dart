import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';

class ContainerWidget extends StatelessWidget {
  ContainerWidget({Key? key, required this.width, required this.hight})
      : super(key: key);
  double width;
  double hight;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
        color: MakeMyTripColors.color10gray,
      ),
      width: width,
      height: hight,
    );
  }
}
