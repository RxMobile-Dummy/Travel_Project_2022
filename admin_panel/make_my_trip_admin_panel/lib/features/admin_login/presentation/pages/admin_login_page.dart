import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/core/base/base_state.dart';
import 'package:make_my_trip_admin_panel/core/navigation/route_info.dart';
import 'package:make_my_trip_admin_panel/features/admin_login/presentation/cubit/admin_login_cubit.dart';
import 'package:make_my_trip_admin_panel/utils/constants/image_path.dart';
import 'package:make_my_trip_admin_panel/utils/constants/string_constants.dart';
import 'package:make_my_trip_admin_panel/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:make_my_trip_admin_panel/utils/widgets/common_primary_button.dart';

class AdminLoginPage extends StatelessWidget {
  AdminLoginPage({Key? key}) : super(key: key);
  bool passwordObSecure = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminLoginCubit, BaseState>(
      listener: (context, state) {
        if (state is StateOnKnownToSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.bookingModerationPage, (route) => false);
        }
      },
      builder: (context, state) {
        if (state is StateOnSuccess) {
          passwordObSecure = state.response;
        }
        return Scaffold(
          body: Center(
            child: SizedBox(
              height: 600,
              width: 600,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: AlignmentDirectional.center,
                          child: Image.asset(
                            ImagePath.logoImg,
                            fit: BoxFit.fill,
                            height: 240,
                            width: 320,
                          ),
                        ),
                        32.verticalSpace,
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          autofocus: true,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person),
                            hintText: StringConstants.emailHintTxt,
                            labelText: StringConstants.emailLabel,
                          ),
                        ),
                        20.verticalSpace,
                        TextFormField(
                          controller: passwordController,
                          obscureText: passwordObSecure,
                          keyboardType: TextInputType.emailAddress,
                          autofocus: true,
                          decoration: InputDecoration(
                            labelText: StringConstants.passwordLabel,
                            prefixIcon: const Icon(Icons.key),
                            hintText: StringConstants.passwordHintTxt,
                            suffixIcon: GestureDetector(
                              child: Icon((passwordObSecure)
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onTap: () {
                                BlocProvider.of<AdminLoginCubit>(context)
                                    .changeObSecureEvent(passwordObSecure);
                              },
                            ),
                          ),
                        ),
                        24.verticalSpace,
                        Align(
                          alignment: AlignmentDirectional.bottomEnd,
                          child: state is StateErrorGeneral
                              ? Text(
                                  state.errorMessage,
                                )
                              : const Text(""),
                        ),
                        12.verticalSpace,
                        SizedBox(
                            width: double.infinity,
                            child: CommonPrimaryButton(
                                text: "Login",
                                onTap: () {
                                  context
                                      .read<AdminLoginCubit>()
                                      .signInWithEmail(emailController.text,
                                          passwordController.text);
                                })),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
