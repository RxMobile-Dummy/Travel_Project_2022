import 'package:flutter/material.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

import '../../../../core/theme/make_my_trip_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../utils/constants/image_path.dart';
import '../../../../utils/constants/string_constants.dart';

class EmailVerification extends StatelessWidget {
  const EmailVerification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MakeMyTripColors.colorWhite,
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                "Change Email",
                style: AppTextStyles.infoContentStyle
                    .copyWith(color: MakeMyTripColors.accentColor),
              ),
            ),
          )
        ],
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Text(
              "Verify Your Account",
              style: AppTextStyles.labelStyle2
                  .copyWith(color: MakeMyTripColors.colorBlack),
            ),
            16.verticalSpace,
            Image.asset(ImagePath.emailVerification),
            8.verticalSpace,
            Text(
              StringConstants.emailVerificationTxt,
              style: AppTextStyles.unselectedLabelStyle.copyWith(
                  color: MakeMyTripColors.colorBlack,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            40.verticalSpace,
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
