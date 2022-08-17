import 'package:flutter/material.dart';

class CheckboxWidget extends StatefulWidget {
 CheckboxWidget({Key? key,required this.value,required this.title}) : super(key: key);
  bool value;
  String title;
  List<String> data = [];

  @override
  State<CheckboxWidget> createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: CheckboxListTile(
          value: widget.value,
          onChanged: (bool? newValue) {
            setState(() {
              widget.value = newValue!;
            });
          },
          title: Text(widget.title),
        )
    );
  }
}
