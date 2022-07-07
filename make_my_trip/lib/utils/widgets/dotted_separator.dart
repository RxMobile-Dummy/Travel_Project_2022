import 'package:flutter/material.dart';

class DottedSeparator extends StatelessWidget {
  const DottedSeparator(
      {Key? key,
      this.height = 1,
      this.color = Colors.grey,
      this.dashWidth = 5.0})
      : super(key: key);
  final double height, dashWidth;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(
            dashCount,
            (_) {
              return SizedBox(
                width: dashWidth,
                height: dashHeight,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: color),
                ),
              );
            },
          ),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
