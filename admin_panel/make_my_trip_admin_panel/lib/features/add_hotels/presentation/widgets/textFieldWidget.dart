import 'package:flutter/material.dart';

class TextFieldView extends StatelessWidget {
  TextFieldView({Key? key, required this.hintTextvar, required this.textFieldViewController}) : super(key: key);
  final String hintTextvar;
  var textFieldViewController;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: TextFormField(

        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          fillColor: Colors.grey[280],
          filled: true,
          hintText: hintTextvar,
          hintStyle: TextStyle(color: Colors.grey[400],fontSize: 16),),
        controller: textFieldViewController,
      ),
    );
  }
}