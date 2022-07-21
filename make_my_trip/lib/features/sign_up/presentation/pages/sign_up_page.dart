import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/login/presentation/widgets/social_buttons.dart';
import 'package:make_my_trip/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:make_my_trip/features/sign_up/presentation/widgets/text_field.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:make_my_trip/utils/widgets/common_primary_button.dart';

import '../../../../core/navigation/route_info.dart';
import '../../../../utils/constants/image_path.dart';
import '../../../login/presentation/cubit/login_cubit.dart';
import '../../../login/presentation/widgets/icon_button.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController fullname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController conPassword = TextEditingController();

  SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: BlocConsumer<SignUpCubit, SignUpState>(
              listener: (context, state) {
            if (state is SignUpSuccessState) {
              Navigator.pushNamedAndRemoveUntil(
                  context, RoutesName.home, (route) => true);
            }
          }, builder: (context, state) {
            if (state is WaitingDialog) {
              return const AlertDialog(
                title: Text("We have send you mail, Please confirm"),
                content: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    FractionallySizedBox(
                      widthFactor: .8,
                      child: Image.asset(
                        ImagePath.appLogo,
                      ),
                    ),
                    8.verticalSpace,
                    TextFieldView(
                      hint: StringConstants.fullnameTxt,
                      controller: fullname,
                    ),
                    TextFieldView(
                      hint: StringConstants.emailTxt,
                      controller: email,
                    ),
                    TextFieldView(
                      hint: StringConstants.passwordTxt,
                      controller: password,
                      obscure: true,
                    ),
                    TextFieldView(
                      hint: StringConstants.conpassowrdTxt,
                      controller: conPassword,
                      obscure: true,
                    ),
                    Align(
                        alignment: const Alignment(0.8, 0),
                        child: (state is SignUpErrorState)
                            ? Padding(
                                padding: const EdgeInsets.only(
                                  top: 8,
                                ),
                                child: Text(
                                  "*${state.error}",
                                  style: const TextStyle(
                                      color: MakeMyTripColors.colorRed),
                                ),
                              )
                            : const SizedBox()),
                    16.verticalSpace,
                    FractionallySizedBox(
                      widthFactor: 1,
                      child: CommonPrimaryButton(
                          text: StringConstants.signUpTxt,
                          onTap: () {
                            BlocProvider.of<SignUpCubit>(context)
                                .signUpWithEmail(
                                    signUpEmail: email.text,
                                    signUpPassword: password.text,
                                    signUpConfirmPassword: conPassword.text,
                                    signUpFullname: fullname.text);
                          }),
                    ),
                    16.verticalSpace,
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
                        StringConstants.orSignupWith,
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
                            text: StringConstants.alreadyAccount,
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
                                Navigator.pop(context);
                              },
                            text: StringConstants.loginTxt,
                            style: AppTextStyles.infoContentStyle2,
                          )
                        ])),
                  ],
                ),
              );
            }
          }),
        ),
      ),
    ));
  }
}
