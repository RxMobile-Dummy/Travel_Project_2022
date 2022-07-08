
import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';

class TextFieldView extends StatelessWidget {
   TextFieldView({Key? key, required this.hintTextvar, required this.textFieldViewController, this.obscuretext}) : super(key: key);
  final String hintTextvar;
   final  textFieldViewController;
   final obscuretext;

  @override
  Widget build(BuildContext context) {

    return  Padding(
      padding:  EdgeInsets.symmetric(vertical: 6, horizontal: 25),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding:  EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          fillColor: MakeMyTripColors.color10gray,
          filled: true,
          hintText: hintTextvar,
         // hintStyle: TextStyle(color: MakeMyTripColors.color50gray,fontSize: 16),
          hintStyle: AppTextStyles.labelDescriptionStyle,
        ),
        //
        controller:textFieldViewController,
        obscureText: obscuretext,
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
