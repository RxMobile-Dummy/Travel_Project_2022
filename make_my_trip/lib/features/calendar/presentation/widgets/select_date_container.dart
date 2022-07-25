import 'package:flutter/material.dart';

class SelectDateContainer extends StatelessWidget {
  final String label, detail;
  final String? subDetail;
  final IconData iconData;
  final VoidCallback onTap;

  const SelectDateContainer(
      {Key? key,
      required this.label,
      required this.detail,
      this.subDetail,
      required this.iconData,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                iconData,
                color: Colors.grey,
              ),
            ),
            RichText(
                text: TextSpan(
                    text: "$label\n",
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                    children: [
                  TextSpan(
                      text: "$detail ",
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 16),
                      children: [
                        TextSpan(
                            text: subDetail ?? "",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.normal))
                      ])
                ]))
          ],
        ),
      ),
    );
  }
}
