import 'package:flutter/material.dart';

class ListContainer extends StatelessWidget {
  ListContainer({Key? key, required this.width, required this.hight})
      : super(key: key);
  double width;
  double hight;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.grey,
          borderRadius: const BorderRadius.all(const Radius.circular(12))),
      width: width,
      height: hight,
    );
  }
}
