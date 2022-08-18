import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:make_my_trip_admin_panel/core/responsive/responsive.dart';
import 'package:make_my_trip_admin_panel/utils/extensions/sizedbox/sizedbox_extension.dart';

import '../../core/theme/make_my_trip_colors.dart';
import '../constants/image_path.dart';
import 'common_primary_button.dart';

class CommonErrorWidget extends StatelessWidget {
  const CommonErrorWidget({
    Key? key,
    this.imagePath,
    this.title,
    this.statusCode,
    this.onTap,
  }) : super(key: key);

  final String? imagePath;
  final String? title;
  final String? statusCode;
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
              statusCode ?? "Something Went wrong",
              style: TextStyle(
                  color: MakeMyTripColors.colorBlack.withOpacity(.8),
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            18.verticalSpace,
            Text(
              title ??
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
                    widthFactor: .07,
                    child: CommonPrimaryButton(
                        text: "Retry", onTap: onTap ?? () {}))
          ],
        ),
      ),
    );
  }
}
