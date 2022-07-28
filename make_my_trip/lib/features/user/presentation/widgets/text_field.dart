import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';

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
      padding: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyles.labelDescriptionStyle,
        ),
        controller: controller,
        obscureText: obscure ?? false,
      ),
    );
  }
}
