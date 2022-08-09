import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/user/presentation/cubit/user_cubit.dart';
import 'package:make_my_trip/features/user/presentation/widgets/social_buttons.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:make_my_trip/utils/widgets/common_primary_button.dart';
import '../../../../core/navigation/route_info.dart';
import '../../../../utils/constants/image_path.dart';
import '../../../../utils/widgets/progress_loader.dart';

class SignUpPage extends StatefulWidget{

  SignUpPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with WidgetsBindingObserver{
  final TextEditingController fullName = TextEditingController();

  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  final TextEditingController conPassword = TextEditingController();

  bool pass = true;

  bool conPass = true;

  String error = "";
  bool mailSent = false;
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addObserver(this);
  // }
  //
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state){
  //   if(state ==AppLifecycleState.resumed){
  //     //BlocProvider.of<UserCubit>(context).userVerificationmethod();
  //     ProgressDialog.hideLoadingDialog(context);
  //   }
  //
  // }
  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: BlocConsumer<UserCubit, BaseState>(listener: (context, state) {
            if (state is StateOnSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                  context, RoutesName.home, (route) => true);
            } else if(state is StateErrorGeneral){
              ProgressDialog.hideLoadingDialog(context);
            } else if (state is StateLoading) {
              if(mailSent==false) {
                ProgressDialog.showLoadingDialog(
                    context, message: StringConstants.loggedIn);
              }
              else{
                ProgressDialog.showLoadingDialog(
                    context, message: StringConstants.pleaseCheckemailTxt);
              }
            } else if (state is StateShowSearching) {
              ProgressDialog.hideLoadingDialog(context);
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) {
                    return AlertDialog(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(32.0))),
                      elevation: 4,
                      title: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 1.6,
                            child: Image.asset(
                              ImagePath.sendMail,
                            ),
                          ),
                          30.verticalSpace,
                          const Text(
                            "Email Verified successfully ! You are successfully logged in!",
                            style: TextStyle(
                                color: MakeMyTripColors.accentColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          25.verticalSpace,
                          SizedBox(
                            width: double.infinity,
                            child: CommonPrimaryButton(
                                text: "Ok",
                                onTap: () {
                                  Navigator.pushNamedAndRemoveUntil(context, RoutesName.home, (route) => false);
                                }),
                          ),
                        ],
                      ),
                    );
                  });
            }
          }, builder: (context, state) {
            if (state is StateOnKnownToSuccess) {
              pass = state.response;
            } else if (state is StateOnResponseSuccess) {
              conPass = state.response;
            } else if (state is StateErrorGeneral) {
              error = state.errorMessage;

            }
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
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: StringConstants.fullnameTxt,
                    ),
                    controller: fullName,
                  ),
                  12.verticalSpace,
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: StringConstants.emailTxt,
                    ),
                    controller: email,
                  ),
                  12.verticalSpace,
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: StringConstants.passwordTxt,
                      suffixIcon: GestureDetector(
                        child: Icon((pass == true)
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onTap: () {
                          mailSent = true;
                          BlocProvider.of<UserCubit>(context)
                              .changeObSecureEvent(pass);
                        },
                      ),
                    ),
                    obscureText: pass,
                    controller: password,
                  ),
                  12.verticalSpace,
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: StringConstants.conPasswordTxt,
                      suffixIcon: GestureDetector(
                        child: Icon((conPass == true)
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onTap: () {
                          mailSent = true;
                          BlocProvider.of<UserCubit>(context)
                              .conPassEyeChange(conPass);
                        },
                      ),
                    ),
                    obscureText: conPass,
                    controller: conPassword,
                  ),
                  Align(
                    alignment: const Alignment(1, 0),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: (error.isEmpty)
                          ? const SizedBox()
                          : Text(
                              "*$error",
                              style: const TextStyle(
                                  color: MakeMyTripColors.colorRed),
                            ),
                    ),
                  ),
                  8.verticalSpace,
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: CommonPrimaryButton(
                        text: StringConstants.signUpTxt,
                        onTap: () {
                          BlocProvider.of<UserCubit>(context).signUpWithEmail(
                              signUpEmail: email.text,
                              signUpPassword: password.text,
                              signUpConfirmPassword: conPassword.text,
                              signUpFullName: fullName.text);
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
                              mailSent = false;
                              Navigator.pop(context);
                            },
                          text: StringConstants.loginTxt,
                          style: AppTextStyles.infoContentStyle2,
                        )
                      ])),
                ],
              ),
            );
          }),
        ),
      ),
    )
    );

  }

}
