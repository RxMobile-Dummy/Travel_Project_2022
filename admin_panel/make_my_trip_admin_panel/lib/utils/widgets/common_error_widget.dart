import 'package:flutter/material.dart';
import 'package:make_my_trip_admin_panel/utils/constants/string_constants.dart';
import 'package:make_my_trip_admin_panel/utils/extensions/sizedbox/sizedbox_extension.dart';

import '../../core/theme/make_my_trip_colors.dart';
import '../constants/image_path.dart';
import 'common_primary_button.dart';

class CommonErrorWidget extends StatelessWidget {
  const CommonErrorWidget({
    Key? key,
    this.imagePath,
    this.subTitle,
    this.title,
    this.onTap,
  }) : super(key: key);

  final String? imagePath;
  final String? title;
  final String? subTitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 4,
              child: Image.asset(
                imagePath ?? ImagePath.serverFailImg,
              ),
            ),
            30.verticalSpace,
            Text(
              title ?? StringConstants.serverErrorMessage,
              style: TextStyle(
                  color: MakeMyTripColors.colorBlack.withOpacity(.8),
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            18.verticalSpace,
            Text(
              subTitle ?? StringConstants.serverErrorTryAgainMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: MakeMyTripColors.colorBlack.withOpacity(.7),
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            18.verticalSpace,
            (onTap == null)
                ? const SizedBox.shrink()
                : FractionallySizedBox(
                    widthFactor: .07,
                    child: CommonPrimaryButton(
                        text: StringConstants.retryButtonTxt,
                        onTap: onTap ?? () {})),
          ],
        ),
      ),
    );
  }
}
