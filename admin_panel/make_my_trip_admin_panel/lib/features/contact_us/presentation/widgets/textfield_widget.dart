import 'package:flutter/material.dart';

import '../../../../core/theme/text_styles.dart';

class ContactUsBody extends StatelessWidget {
  ContactUsBody(
      {Key? key,
      required this.title,
      required this.controller,
      required this.hinttxt})
      : super(key: key);

  final String title;
  final String hinttxt;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
                AppTextStyles.labelStyle.copyWith(fontWeight: FontWeight.w300),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: hinttxt,
                  hintStyle: AppTextStyles.unselectedLabelStyle
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w300)),
            ),
          )
        ],
      ),
    );
  }
}
