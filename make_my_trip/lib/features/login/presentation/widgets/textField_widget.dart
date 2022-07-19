import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';

class TextFieldView extends StatelessWidget {
  TextFieldView(
      {Key? key,
      required this.hintTextvar,
      required this.textFieldViewController})
      : super(key: key);
  final String hintTextvar;
  var textFieldViewController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: TextFormField(
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            fillColor: Colors.grey[280],
            filled: true,
            hintText: hintTextvar,
            hintStyle: AppTextStyles.labelDescriptionStyle
                .copyWith(color: MakeMyTripColors.color70gray)),
        controller: textFieldViewController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Your email';
          }
          return null;
        },
      ),
    );
  }
}
