import 'package:flutter/material.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import '../../../../core/theme/make_my_trip_colors.dart';
import '../../../../core/theme/text_styles.dart';

class CustomListTile extends StatelessWidget {
  CustomListTile(this.title, this.iconName, {Key? key}) : super(key: key);
  String title;
  IconData iconName;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        height: 50,
        color: MakeMyTripColors.colorWhite,
        child: Row(
          children: <Widget>[
            20.horizontalSpace,
            Icon(
              iconName,
              color: MakeMyTripColors.accentColor,
            ),
            10.horizontalSpace,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: AppTextStyles.infoContentStyle,
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: MakeMyTripColors.accentColor),
            8.horizontalSpace
          ],
        ),
      ),
    );
  }
}
