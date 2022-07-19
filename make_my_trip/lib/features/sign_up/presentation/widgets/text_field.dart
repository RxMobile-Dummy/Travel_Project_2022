import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/home_page/presentation/pages/homescreen.dart';
import 'package:make_my_trip/features/sign_up/presentation/cubit/sign_up_cubit.dart';

class TextFieldView extends StatelessWidget {
  const TextFieldView({
    Key? key,
    required this.hint,
    required this.controller,
    this.obscure,
  }) : super(key: key);
  final String hint;
  final TextEditingController controller;
  final bool? obscure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 25),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          fillColor: MakeMyTripColors.color10gray,
          filled: true,
          hintText: hint,
          hintStyle: AppTextStyles.labelDescriptionStyle,
        ),
        //
        controller: controller,
        obscureText: obscure ?? false,
      ),
    );
  }
}