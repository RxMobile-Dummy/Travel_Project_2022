import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key? key,
    required this.backColor,
    required this.text,
    required this.icon,
    required this.textColor,
    required this.onTap,
  }) : super(key: key);

  final Color backColor, textColor;
  final String text;
  final Widget icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(vertical: 8),
            primary: backColor),
        icon: icon,
        label: Text(text, style: TextStyle(color: textColor, fontSize: 16)));
  }
}
