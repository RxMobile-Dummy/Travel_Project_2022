import 'package:flutter/material.dart';

class CheckboxWidget extends StatefulWidget {
  CheckboxWidget(
      {Key? key, required this.value, required this.title, required this.data})
      : super(key: key);
  bool value;
  String title;
  List<String> data;

  @override
  State<CheckboxWidget> createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: widget.value,
      onChanged: (bool? newValue) {
        setState(() {
          // widget.data.add(widget.title);
          widget.value = newValue!;
        });
        if (widget.value == true) {
          widget.data.add(widget.title);
        }
      },
      title: Text(widget.title),
    );
  }
}
