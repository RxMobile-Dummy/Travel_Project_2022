import 'package:flutter/material.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import '../../../../core/theme/make_my_trip_colors.dart';

class HomeFeaturesWidget extends StatelessWidget {
  const HomeFeaturesWidget({
    Key? key,
    required this.iconData,
    required this.text,
    required this.onTap,
  }) : super(key: key);
  final IconData iconData;
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screen.width / 4 - 16,
        padding: EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
            color: MakeMyTripColors.accentColor.withOpacity(.2),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Icon(
              iconData,
              size: 32,
            ),
            8.verticalSpace,
            Text(text),
          ],
        ),
      ),
    );
  }
}
