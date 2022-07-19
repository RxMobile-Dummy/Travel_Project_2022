import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/features/login/presentation/widgets/textField_widget.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

import '../../../../core/theme/make_my_trip_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../cubit/login_cubit.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({Key? key}) : super(key: key);

  TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MakeMyTripColors.colorWhite,
      appBar: AppBar(
        title: Text(
          StringConstants.resetPassword,
          style: TextStyle(color: MakeMyTripColors.colorBlack),
        ),
        backgroundColor: MakeMyTripColors.colorWhite,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Image.asset(ImagePath.forgetPassword),
              8.verticalSpace,
              Text(
                StringConstants.passwordLbl,
                style: AppTextStyles.infoContentStyle,
                textAlign: TextAlign.center,
              ),
              80.verticalSpace,
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  StringConstants.emailAddress,
                  style: AppTextStyles.hintTextStyle.copyWith(
                    color: MakeMyTripColors.color50gray,
                  ),
                ),
              ),
              8.verticalSpace,
              TextFieldView(
                  hintTextvar: StringConstants.hintText,
                  textFieldViewController: _email),
              40.verticalSpace,
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          MakeMyTripColors.accentColor),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        StringConstants.sendLink,
                        style: AppTextStyles.confirmButtonTextStyle,
                      ),
                    ),
                    onPressed: () {
                      context
                          .read<LoginCubit>()
                          .userForgetPassword(_email.text);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
