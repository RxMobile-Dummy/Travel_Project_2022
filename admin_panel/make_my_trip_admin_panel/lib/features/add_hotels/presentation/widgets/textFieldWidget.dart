import 'package:flutter/material.dart';

class TextFieldView extends StatelessWidget {
  TextFieldView({Key? key, required this.hintTextvar, required this.textFieldViewController, this.validator,this.inputType,this.onChange}) : super(key: key);
  final String hintTextvar;
  var textFieldViewController;
  String? Function(String?)? validator;
  var inputType;
  String? Function(String?)? onChange;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: TextFormField(
        onChanged: onChange,
        keyboardType: inputType,
        validator: validator,
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