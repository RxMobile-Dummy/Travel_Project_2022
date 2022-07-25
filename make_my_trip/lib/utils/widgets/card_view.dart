import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;
  final ShapeBorder? shape;
  final VoidCallback? onTap;
  final Widget? child;
  final double? elevation;
  final bool isSlidable;
  final Color? backgroudColor;

  const CardView({
    this.margin,
    this.borderRadius,
    this.shape,
    this.onTap,
    this.elevation,
    this.backgroudColor,
    this.isSlidable = false,
    @required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: backgroudColor,
        margin: margin ??
            (isSlidable
                ? const EdgeInsets.only(top: 5, left: 5, bottom: 5)
                : const EdgeInsets.all(5)),
        shape: shape ??
            CardTheme.of(context).shape ??
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
        elevation: elevation ?? CardTheme.of(context).elevation ?? 1.0,
        child: InkWell(
          borderRadius: borderRadius ?? BorderRadius.circular(10),
          onTap: onTap ?? () {},
          child: child,
        ));
  }
}
