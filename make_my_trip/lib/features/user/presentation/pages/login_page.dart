import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/user/presentation/cubit/user_cubit.dart';
import 'package:make_my_trip/features/user/presentation/widgets/social_buttons.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:make_my_trip/utils/widgets/common_primary_button.dart';
import '../../../../utils/widgets/progress_loader.dart';

class LoginPage extends StatefulWidget{
  LoginPage({Key? key, required this.arg}) : super(key: key);
  final Map<String, dynamic> arg;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with WidgetsBindingObserver {
  final loginEmailController = TextEditingController();

  final loginPasswordController = TextEditingController();

  bool passwordObSecure = true;
  bool mailsent = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state ==AppLifecycleState.resumed){
      ProgressDialog.hideLoadingDialog(context);
      BlocProvider.of<UserCubit>(context).userVerificationmethod();
    }

  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, BaseState>(
      listener: (context, state) {
        if (state is StateLoading) {
          if(mailsent==true){
            ProgressDialog.showLoadingDialog(context,
                message: StringConstants.pleaseCheckemailTxt);
          }
          else {
            ProgressDialog.showLoadingDialog(context,
                message: StringConstants.loggedIn);
          }
        } else if (state is StateOnSuccess) {
          ProgressDialog.hideLoadingDialog(context);
          if (widget.arg["route_name"] == RoutesName.roomCategory ||
              widget.arg["route_name"] == RoutesName.roomDetail ||
              widget.arg["route_name"] == RoutesName.hotelDetail ||
              widget.arg["route_name"] == RoutesName.reviewPage) {
            Navigator.pop(context);
          } else {
            Navigator.pushReplacementNamed(context, widget.arg["route_name"]);
          }
        } else {
          ProgressDialog.hideLoadingDialog(context);
        }
        if(state is StateErrorGeneral) {
          if(state.errorMessage=="Email is not verified"){
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
                        Text(
                          "Your email is not verified...Please Verify your email",
                          style: const TextStyle(
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
                              onTap: () async {
                                mailsent=true;
                               await BlocProvider.of<UserCubit>(context).sendEmailVerification(loginEmailController.text,loginPasswordController.text);
                               Navigator.of(context).pop();
                              }),
                        ),
                      ],
                    ),
                  );
                });
          }
        }
        else if(state is StateShowSearching){
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
                      Text(
                        "Email Verified successfully ! You are successfully logged in!",
                        style: const TextStyle(
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
      },
      child: Scaffold(
        body: SafeArea(
            child: Stack(children: [
          Container(
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
                  BlocBuilder<UserCubit, BaseState>(
                    builder: (context, state) {
                      return TextFormField(
                        controller: loginEmailController
                          ..text = state is StateReorderSuccess
                              ? state.response
                              : loginEmailController.text
                          ..selection = TextSelection.collapsed(
                              offset: loginEmailController.text.length),
                        decoration:
                            InputDecoration(hintText: StringConstants.emailTxt),
                        onChanged: (val) {
                          context.read<UserCubit>().emailChanged(val);
                        },
                      );
                    },
                  ),
                  16.verticalSpace,
                  BlocBuilder<UserCubit, BaseState>(
                    builder: (context, state) {
                      if (state is StateOnKnownToSuccess) {
                        passwordObSecure = state.response;
                      }
                      return TextFormField(
                        decoration: InputDecoration(
                          hintText: StringConstants.passwordTxt,
                          suffixIcon: GestureDetector(
                            child: Icon((passwordObSecure)
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onTap: () {
                              BlocProvider.of<UserCubit>(context)
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
                          Navigator.of(context).pushNamed('/resetPassword',
                              arguments: {'context': context});
                        },
                        child: Text(
                          StringConstants.forgotPass,
                          style: AppTextStyles.hintTextStyle
                              .copyWith(color: MakeMyTripColors.color50gray),
                        )),
                  ),
                  16.verticalSpace,
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: CommonPrimaryButton(
                      text: StringConstants.loginTxt,
                      onTap: () {
                        BlocProvider.of<UserCubit>(context).signInWithEmail(
                            loginEmailController.text,
                            loginPasswordController.text);
                      },
                    ),
                  ),
                  BlocBuilder<UserCubit, BaseState>(
                    builder: (context, state) {
                      return Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: (state is StateErrorGeneral)
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    "*${state.errorMessage}",
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
                              Navigator.pushNamed(context, RoutesName.signup);
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
          Positioned(
            top: 20,
            left: 20,
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.cancel_sharp,
                  size: 28,
                  color: MakeMyTripColors.colorBlack.withOpacity(.6),
                )),
          )
        ])),
      ),
    );
  }
}
