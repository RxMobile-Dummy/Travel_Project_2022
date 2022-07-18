import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/features/login/presentation/widgets/textField_widget.dart';
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
        title: const Text(
          'Forget Password',
          style: TextStyle(color: MakeMyTripColors.colorBlack),
        ),
        backgroundColor: MakeMyTripColors.colorWhite,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Reset Password',
              style: TextStyle(
                  color: MakeMyTripColors.colorBlack,
                  fontWeight: FontWeight.bold,
                  fontSize: 26),
            ),
            8.verticalSpace,
            const Expanded(
                flex: 0,
                child: Text(
                  'Enter the email associated with your account and we will send an email with instrucrions to reset your password.',
                  style: TextStyle(
                      color: MakeMyTripColors.color90gray, fontSize: 16),
                )),
            30.verticalSpace,
            const Text('Email Address',
                style: TextStyle(
                    color: MakeMyTripColors.colorBlack, fontSize: 16)),
            TextFieldView(
                hintTextvar: "helloworld123@gmail.com",
                textFieldViewController: _email),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(MakeMyTripColors.accentColor),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      "Send Link",
                      style: AppTextStyles.confirmButtonTextStyle,
                    ),
                  ),
                  onPressed: () {
                    context.read<LoginCubit>().userForgetPassword(_email.text);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
