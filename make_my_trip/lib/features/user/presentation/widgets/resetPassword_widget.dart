import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/features/user/presentation/cubit/user_cubit.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:make_my_trip/utils/widgets/common_primary_button.dart';

import '../../../../core/theme/make_my_trip_colors.dart';
import '../../../../core/theme/text_styles.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MakeMyTripColors.colorWhite,
      appBar: AppBar(
        title: Text(
          StringConstants.resetPassword,
          style: const TextStyle(color: MakeMyTripColors.colorBlack),
        ),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Image.asset(ImagePath.forgetPassword),
            8.verticalSpace,
            Text(
              StringConstants.passwordLbl,
              style: AppTextStyles.unselectedLabelStyle.copyWith(
                  color: MakeMyTripColors.colorBlack,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            40.verticalSpace,
            TextFormField(
              decoration: InputDecoration(hintText: StringConstants.emailTxt),
              controller: emailController,
            ),
            10.verticalSpace,
            const Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Text(
                  "* error",
                  style:
                      TextStyle(color: MakeMyTripColors.colorRed, fontSize: 16),
                )),
            10.verticalSpace,
            FractionallySizedBox(
              widthFactor: 1,
              child: CommonPrimaryButton(
                  text: StringConstants.sendLink,
                  onTap: () {
                    context
                        .read<UserCubit>()
                        .userForgetPassword(emailController.text);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
