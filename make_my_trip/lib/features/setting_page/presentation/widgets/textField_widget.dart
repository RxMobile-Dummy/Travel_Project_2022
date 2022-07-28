import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';

class TextFieldView extends StatelessWidget {
  TextFieldView(
      {Key? key,
      required this.hintTextVar,
      required this.textFieldViewController,
      required this.keyboardType})
      : super(key: key);
  final String hintTextVar;
  TextInputType keyboardType;
  var textFieldViewController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: TextFormField(
        keyboardType: keyboardType,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            fillColor: MakeMyTripColors.color10gray,
            filled: true,
            hintText: hintTextVar,
            hintStyle: AppTextStyles.hintTextStyle
                .copyWith(fontWeight: FontWeight.w400)),
        controller: textFieldViewController,
      ),
    );
  }
}
