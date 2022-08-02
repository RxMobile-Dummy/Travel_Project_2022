import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  ContainerWidget({Key? key, required this.width,required this.hight}) : super(key: key);
    double width;
    double hight;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.grey,
        ),
        width: width,
        height: hight,
      );

  }
}
