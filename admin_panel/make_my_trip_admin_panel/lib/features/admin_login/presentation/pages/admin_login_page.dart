import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/core/base/base_state.dart';
import 'package:make_my_trip_admin_panel/features/admin_login/presentation/cubit/admin_login_cubit.dart';
import 'package:make_my_trip_admin_panel/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:make_my_trip_admin_panel/utils/widgets/common_primary_button.dart';

class AdminLoginPage extends StatelessWidget {
  AdminLoginPage({Key? key}) : super(key: key);
  bool passwordObSecure = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminLoginCubit, BaseState>(
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
                            "assets/img/logot.png",
                            fit: BoxFit.fill,
                            height: 240,
                            width: 320,
                          ),
                        ),
                        32.verticalSpace,
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          autofocus: true,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person),
                            hintText: "Enter Email",
                            labelText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        16.verticalSpace,
                        TextFormField(
                          obscureText: passwordObSecure,
                          keyboardType: TextInputType.emailAddress,
                          autofocus: true,
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: const Icon(Icons.key),
                            hintText: "Enter password",
                            suffixIcon: GestureDetector(
                              child: Icon((passwordObSecure)
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onTap: () {
                                BlocProvider.of<AdminLoginCubit>(context)
                                    .changeObSecureEvent(passwordObSecure);
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        8.verticalSpace,
                        Align(
                          alignment: AlignmentDirectional.bottomEnd,
                          child: GestureDetector(
                              onTap: () {},
                              child: const Text("Forgot Password")),
                        ),
                        24.verticalSpace,
                        CommonPrimaryButton(text: "Login", onTap: () {}),
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
