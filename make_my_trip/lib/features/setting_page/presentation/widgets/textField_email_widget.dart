import 'package:flutter/material.dart';
class TextFieldViewEmail extends StatelessWidget {
  TextFieldViewEmail({Key? key, required this.hintTextvar, required this.textFieldViewController,required this.keyboardtype,required this.enable,required this.readOnly}) : super(key: key);
  final String hintTextvar;
  TextInputType keyboardtype;
  var textFieldViewController;
  bool readOnly = true;
  bool enable = false;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: TextFormField(
        readOnly: readOnly,
        enabled: enable,
        keyboardType: keyboardtype,
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