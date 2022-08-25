import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:make_my_trip/utils/widgets/common_secondary_button.dart';

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
  final String? subTitle;
  final String? title;
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
              aspectRatio: 1,
              child: Image.asset(
                imagePath ?? ImagePath.serverFailImage,
              ),
            ),
            30.verticalSpace,
            Text(
              title ?? "Something went wrong",
              style: TextStyle(
                  color: MakeMyTripColors.colorBlack.withOpacity(.8),
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            18.verticalSpace,
            Text(
              subTitle ??
                  "We are working on fixing the problem. Please refresh the page and try again.",
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
                    widthFactor: .3,
                    child: CommonSecondaryButton(
                        text: "Retry", onTap: onTap ?? () {}))
          ],
        ),
      ),
    );
  }
}
