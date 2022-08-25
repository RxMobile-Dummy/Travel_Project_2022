import 'package:flutter/material.dart';

class LongTextTextField extends StatelessWidget {
   LongTextTextField({Key? key,required this.hintTextvar, required this.textFieldViewController,required this.validator}) : super(key: key);
  final String hintTextvar;
  var textFieldViewController;
  String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return     Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator:  validator,
        maxLength: 200,
        maxLines: 5,
        controller: textFieldViewController,
        keyboardType: TextInputType.multiline,
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
      ),
    );
  }
}
