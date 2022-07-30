import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/features/user/presentation/cubit/user_cubit.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:make_my_trip/utils/widgets/common_primary_button.dart';

import '../../../../core/theme/make_my_trip_colors.dart';
import '../../../../core/theme/text_styles.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({Key? key}) : super(key: key);



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
      body: BlocBuilder<UserCubit, BaseState>(
        builder: (context, state) {
          TextEditingController emailController = TextEditingController();
          return SingleChildScrollView(
            child: Container(
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
                    decoration: InputDecoration(
                        hintText: StringConstants.emailTxt),
                    controller: emailController..text = state is StateReorderSuccess ? state.response: emailController.text..selection = TextSelection.collapsed(offset: emailController.text.length),
                    onChanged: (val) {
                      context.read<UserCubit>().emailChanged(val);

                    },
                  ),
                  10.verticalSpace,
                  Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text((state is StateReorderSuccess ? (state.updatedIndex==1 ?  "" : StringConstants.enterValidMail) : ""),
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
        },
      ),
    );
  }
}
