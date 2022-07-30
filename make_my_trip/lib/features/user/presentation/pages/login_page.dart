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

class LoginPage extends StatelessWidget {
  LoginPage({Key? key, required this.arg}) : super(key: key);

  final  loginEmailController = TextEditingController();
  final  loginPasswordController = TextEditingController();
  bool passwordObSecure = true;
  final Map<String, dynamic> arg;

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return BlocListener<UserCubit, BaseState>(
      listener: (context, state) {
        if (state is StateLoading) {
          ProgressDialog.showLoadingDialog(context, message: StringConstants.loggedIn);
        } else if (state is StateOnSuccess) {
          ProgressDialog.hideLoadingDialog(context);
          if (arg["route_name"] == RoutesName.roomCategory ||
              arg["route_name"] == RoutesName.roomDetail ||
              arg["route_name"] == RoutesName.hotelDetail ||
              arg["route_name"] == RoutesName.reviewPage) {
            Navigator.pop(context);
            // }
            // else if (arg["route_name"] == RoutesName.reviewPage) {
            //   Navigator.pushReplacementNamed(context, arg["route_name"],
            //       arguments: {
            //         'hotel_id': arg['hotel_id'],
            //         'rating': arg['rating']
            //       });
          } else {
            Navigator.pushReplacementNamed(context, arg["route_name"]);
          }
        } else {
          ProgressDialog.hideLoadingDialog(context);
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
                              : loginEmailController.text..selection = TextSelection.collapsed(offset: loginEmailController.text.length),
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
                              Navigator.pushReplacementNamed(
                                  context, RoutesName.signup,
                                  arguments: {"route_name": arg["route_name"]});
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
