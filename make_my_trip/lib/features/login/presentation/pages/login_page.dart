import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/login/presentation/cubit/login_cubit.dart';
import 'package:make_my_trip/features/login/presentation/widgets/social_buttons.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:make_my_trip/utils/widgets/common_primary_button.dart';

import '../../../../utils/widgets/progress_loader.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key, required this.arg}) : super(key: key);

  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  bool passwordObSecure = true;
  final Map<String, dynamic> arg;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          ProgressDialog.showLoadingDialog(context, message: "Loggin In...");
        } else if (state is LoginSuccessState) {
          ProgressDialog.hideLoadingDialog(context);
          if (arg["route_name"] == RoutesName.roomCategory ||
              arg["route_name"] == RoutesName.roomDetail ){
            Navigator.pop(context);
          } else if(arg["route_name"] == RoutesName.reviewPage){
            Navigator.pushReplacementNamed(context, arg["route_name"],arguments: {'hotel_id':arg['hotel_id'],'rating': arg['rating']});
          }else {
            Navigator.pushReplacementNamed(context, arg["route_name"]);
          }
        } else {
          ProgressDialog.hideLoadingDialog(context);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FractionallySizedBox(
                    widthFactor: .8,
                    child: Image.asset(
                      ImagePath.appLogo,
                    ),
                  ),
                  // 16.verticalSpace,
                  // Text(
                  //   StringConstants.loginTitle,
                  //   style: AppTextStyles.infoContentStyle,
                  //   textAlign: TextAlign.center,
                  // ),
                  20.verticalSpace,
                  TextFormField(
                    controller: loginEmailController,
                    decoration:
                        InputDecoration(hintText: StringConstants.emailTxt),
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
                        onTap: () {
                          Navigator.of(context).pushNamed('/resetPassword');
                        },
                        child: Text(
                          StringConstants.forgotPass,
                          style: AppTextStyles.hintTextStyle
                              .copyWith(color: MakeMyTripColors.color50gray),
                        )),
                  ),
                  16.verticalSpace,
                  // LoginElevatedButtonWidget(
                  //   height: 12,
                  //   onTap: () {
                  //     BlocProvider.of<LoginCubit>(context).signInWithEmail(
                  //         loginEmailController.text,
                  //         loginPasswordController.text);
                  //   },
                  //   width: double.infinity,
                  //   buttonColor: MakeMyTripColors.accentColor,
                  //   child: Text(StringConstants.loginTxt),
                  // ),
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: CommonPrimaryButton(
                      text: StringConstants.loginTxt,
                      onTap: () {
                        BlocProvider.of<LoginCubit>(context).signInWithEmail(
                            loginEmailController.text,
                            loginPasswordController.text);
                      },
                    ),
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
                                    style: const TextStyle(
                                        color: MakeMyTripColors.colorRed),
                                  ),
                                )
                              : const SizedBox());
                    },
                  ),
                  16.verticalSpace,
                  Row(children: [
                    const Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 8.0),
                      child: Divider(
                        thickness: 1,
                        color: MakeMyTripColors.color30gray,
                      ),
                    )),
                    Text(
                      StringConstants.orLoginWith,
                      style: AppTextStyles.hintTextStyle,
                    ),
                    const Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 20.0),
                      child: Divider(
                        thickness: 1,
                        color: MakeMyTripColors.color30gray,
                      ),
                    )),
                  ]),
                  16.verticalSpace,
                  const SocialButton(),
                  16.verticalSpace,
                  RichText(
                      text: TextSpan(
                          text: StringConstants.noAccount,
                          style: AppTextStyles.hintTextStyle,
                          children: [
                        const WidgetSpan(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5.0),
                          ),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, RoutesName.signup, (route) => true);
                            },
                          text: StringConstants.signUpTxt,
                          style: AppTextStyles.infoContentStyle2
                              .copyWith(color: MakeMyTripColors.accentColor),
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
