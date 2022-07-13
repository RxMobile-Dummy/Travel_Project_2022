import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/home_page/presentation/pages/homescreen.dart';
import 'package:make_my_trip/features/sign_up/presentation/cubit/sign_up_cubit.dart';

class TextFieldView extends StatelessWidget {
  TextFieldView(
      {Key? key,
      required this.hintTextvar,
      required this.textFieldViewController,
      this.obscuretext,
      required this.id})
      : super(key: key);
  final String hintTextvar;
  final textFieldViewController;
  final obscuretext;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 25),
      child: TextFormField(
        onChanged: (value) {
          if (id == 2) {
            BlocProvider.of<SignUpCubit>(context).validate_Email(value);
          } else if (id == 1) {
            BlocProvider.of<SignUpCubit>(context).validate_Name(value);
          } else if (id == 3) {
            BlocProvider.of<SignUpCubit>(context).validate_Password(value);
          }
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
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
        controller: textFieldViewController,
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
