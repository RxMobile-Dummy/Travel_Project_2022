import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/login/presentation/cubit/login_cubit.dart';
import 'package:make_my_trip/features/login/presentation/widgets/login_elevated_button_widget.dart';
import 'package:make_my_trip/features/login/presentation/widgets/login_text_form_field_widget.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController loginEmail = TextEditingController();
  final TextEditingController loginPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100, bottom: 32),
                  child:
                      Image.asset(ImagePath.icAppLogo, height: 80, width: 80),
                ),
                const Text(
                  "Meet new people from over millions of",
                  style: AppTextStyles.infoLabelStyle,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    "users. Create posts, find friends and more.",
                    style: AppTextStyles.infoLabelStyle,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(children: [
                    LoginTextFormFieldWidget(
                      hintText: StringConstants.emailTxt,
                      obSecure: false,
                      controller: loginEmail,
                    ),
                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        if (state is ChangeState) {
                          return LoginTextFormFieldWidget(
                            hintText: StringConstants.passwordTxt,
                            iconButton: IconButton(
                              icon: state.obSecure == true
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                              onPressed: () {
                                BlocProvider.of<LoginCubit>(context)
                                    .changeObSecureEvent(state.obSecure);
                              },
                            ),
                            obSecure: state.obSecure,
                            controller: loginPassword,
                          );
                        } else {
                          return LoginTextFormFieldWidget(
                            hintText: StringConstants.passwordTxt,
                            iconButton: IconButton(
                              icon: const Icon(Icons.visibility_off),
                              onPressed: () {
                                BlocProvider.of<LoginCubit>(context)
                                    .changeObSecureEvent(true);
                              },
                            ),
                            obSecure: true,
                            controller: loginPassword,
                          );
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 22.0),
                      child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forgot Password?",
                              style: AppTextStyles.labelDescriptionStyle,
                            )),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 28.0),
                        child: LoginElevatedButtonWidget(
                          height: 40,
                          onTap: () {},
                          width: double.infinity,
                          buttonColor: MakeMyTripColors.accentColor,
                          child: Text(StringConstants.loginTxt),
                        )),
                  ]),
                ),
                Row(children: const [
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(left: 32.0, right: 8.0),
                    child: Divider(
                        thickness: 0.5, color: MakeMyTripColors.color70gray),
                  )),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.0),
                    child: Text(
                      "Or Login with",
                      style: AppTextStyles.labelDescriptionStyle,
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 32.0),
                    child: Divider(
                      thickness: 0.5,
                      color: MakeMyTripColors.color70gray,
                    ),
                  )),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    LoginElevatedButtonWidget(
                        onTap: () {},
                        height: 36,
                        width: 150,
                        buttonColor: MakeMyTripColors.accentColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text("Facebook"),
                            Image.asset(
                              ImagePath.icFacebookLogo,
                              height: 20,
                              width: 20,
                            ),
                          ],
                        )),
                    LoginElevatedButtonWidget(
                      onTap: () {
                        BlocProvider.of<LoginCubit>(context).googlesignin();
                      },
                      height: 36,
                      width: 150,
                      buttonColor: MakeMyTripColors.color30gray,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "Google",
                            style:
                                TextStyle(color: MakeMyTripColors.colorBlack),
                          ),
                          Image.asset(
                            ImagePath.icGoogleLogo,
                            height: 20,
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Or don't have account?",
                        style: AppTextStyles.labelDescriptionStyle,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            StringConstants.signUpTxt,
                            style: AppTextStyles.labelDescriptionStyle,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
