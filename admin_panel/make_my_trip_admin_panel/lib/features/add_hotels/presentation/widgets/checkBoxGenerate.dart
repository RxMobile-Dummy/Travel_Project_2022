import 'package:flutter/material.dart';

class checkValue extends StatefulWidget {
  const checkValue({Key? key}) : super(key: key);

  @override
  State<checkValue> createState() => _checkValueState();
}

class _checkValueState extends State<checkValue> {
  Map<String, bool> values = {
    'foo': true,
    'bar': false,
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: values.keys.map((String key) {
        return CheckboxListTile(
        title: Text(key),
        value: values[key],
          onChanged: (bool? value) {
            setState(() {
              values[key] = value!;
            });
          },
      );
    }).toList(),
    )
    );
  }
}
