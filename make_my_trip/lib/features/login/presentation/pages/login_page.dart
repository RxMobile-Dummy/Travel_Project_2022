import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/login/presentation/cubit/login_cubit.dart';
import 'package:make_my_trip/features/login/presentation/widgets/login_elevated_button_widget.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

import '../widgets/icon_button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  bool passwordObSecure = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          Navigator.pushNamed(context, RoutesName.home);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(ImagePath.icAppLogo, height: 72, width: 72),
                  16.verticalSpace,
                  Text(
                    "Meet new people from over millions of\nusers. Create posts, find friends and more.",
                    style: AppTextStyles.infoContentStyle,
                    textAlign: TextAlign.center,
                  ),
                  32.verticalSpace,
                  TextFormField(
                    controller: loginEmailController,
                    decoration: const InputDecoration(hintText: "Email"),
                  ),
                  16.verticalSpace,
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      if (state is LoginObSecureChangeState) {
                        passwordObSecure = state.obSecure;
                      }
                      return TextFormField(
                        decoration: InputDecoration(
                          hintText: StringConstants.passwordTxt,
                          suffixIcon: GestureDetector(
                            child: Icon((passwordObSecure)
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onTap: () {
                              BlocProvider.of<LoginCubit>(context)
                                  .changeObSecureEvent(passwordObSecure);
                            },
                          ),
                        ),
                        obscureText: passwordObSecure,
                        controller: loginPasswordController,
                      );
                    },
                  ),
                  16.verticalSpace,
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: GestureDetector(
                        onTap: () {},
                        child: const Text(
                          "Forgot Password?",
                          style: AppTextStyles.hintTextStyle,
                        )),
                  ),
                  16.verticalSpace,
                  LoginElevatedButtonWidget(
                    height: 12,
                    onTap: () {
                      BlocProvider.of<LoginCubit>(context).signInWithEmail(
                          loginEmailController.text,
                          loginPasswordController.text);
                    },
                    width: double.infinity,
                    buttonColor: MakeMyTripColors.colorCwsPrimary,
                    child: Text(StringConstants.loginTxt),
                  ),
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      return Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: (state is LoginErrorState)
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    "*${state.error}",
                                    style: TextStyle(
                                        color: MakeMyTripColors.colorRed),
                                  ),
                                )
                              : SizedBox());
                    },
                  ),
                  16.verticalSpace,
                  Row(children: const [
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 8.0),
                      child: Divider(
                        thickness: 1,
                        color: MakeMyTripColors.color30gray,
                      ),
                    )),
                    Text(
                      "or login with",
                      style: AppTextStyles.hintTextStyle,
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 20.0),
                      child: Divider(
                        thickness: 1,
                        color: MakeMyTripColors.color30gray,
                      ),
                    )),
                  ]),
                  16.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: CustomIconButton(
                          backColor: Color(0xff3b5998),
                          icon: Icon(Icons.facebook_rounded),
                          text: "Facebook",
                          textColor: MakeMyTripColors.colorWhite,
                          onTap: () {
                            BlocProvider.of<LoginCubit>(context)
                                .signInWithFacebook();
                          },
                        ),
                      ),
                      16.horizontalSpace,
                      Expanded(
                        child: CustomIconButton(
                            backColor: MakeMyTripColors.colorWhite,
                            textColor: MakeMyTripColors.colorBlack,
                            icon: Image.asset(
                              ImagePath.icGoogleLogo,
                              width: 24,
                            ),
                            onTap: () {
                              BlocProvider.of<LoginCubit>(context)
                                  .signInWithGoogle();
                            },
                            text: "Google"),
                      ),
                    ],
                  ),
                  16.verticalSpace,
                  RichText(
                      text: TextSpan(
                          text: "Or don't have account? ",
                          style: AppTextStyles.hintTextStyle,
                          children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print("signup");
                            },
                          text: StringConstants.signUpTxt,
                          style: AppTextStyles.infoContentStyle2,
                        )
                      ])),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
