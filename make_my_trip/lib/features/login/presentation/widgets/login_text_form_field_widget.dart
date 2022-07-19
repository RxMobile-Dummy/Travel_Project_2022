import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/login/presentation/cubit/login_cubit.dart';

class LoginTextFormFieldWidget extends StatelessWidget {
  final String hintText;
  final IconButton? iconButton;
  final bool obSecure;
  final TextEditingController controller;

  const LoginTextFormFieldWidget(
      {Key? key,
      required this.hintText,
      this.iconButton,
      required this.obSecure,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 28.0, right: 28.0),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return TextFormField(
            obscureText: obSecure,
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                hintText: hintText,
                suffixIcon: iconButton,
                hintStyle: AppTextStyles.hintTextStyle,
                filled: true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                )),
          );
        },
      ),
    );
  }
}
