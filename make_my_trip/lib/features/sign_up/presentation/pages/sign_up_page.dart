import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:make_my_trip/features/sign_up/presentation/widgets/continue_button.dart';
import 'package:make_my_trip/features/sign_up/presentation/widgets/termsAndPrivacy.dart';
import 'package:make_my_trip/features/sign_up/presentation/widgets/text_field.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

import '../../../../core/navigation/route_info.dart';

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
      child: SingleChildScrollView(
        child:
            BlocConsumer<SignUpCubit, SignUpState>(listener: (context, state) {
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
            return Column(
              children: [
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
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ContinueButton(onTap: () {
                    BlocProvider.of<SignUpCubit>(context).signUpWithEmail(
                        signUpEmail: email.text,
                        signUpPassword: password.text,
                        signUpConfirmPassword: conPassword.text,
                        signUpFullname: fullname.text);
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 4.0),
                  child: Text(
                    StringConstants.tc,
                    style: AppTextStyles.labelDescriptionStyle,
                  ),
                ),
                const TermsAndPrivacyButton(),
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
                            Navigator.pop(context);
                          },
                        text: StringConstants.signUpTxt,
                        style: AppTextStyles.infoContentStyle2,
                      )
                    ])),
              ],
            );
          }
        }),
      ),
    ));
  }
}
