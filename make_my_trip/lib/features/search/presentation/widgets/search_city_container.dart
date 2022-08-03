import 'package:flutter/material.dart';

import '../../../../core/theme/text_styles.dart';

class SearchCityContainer extends StatelessWidget {
  final String label, detail;
  final String? subDetail;
  final IconData iconData;
  final VoidCallback onTap;

  const SearchCityContainer(
      {key,
      required this.label,
      required this.detail,
      this.subDetail,
      required this.iconData,
      required this.onTap});

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
            Flexible(
              child: RichText(
                  softWrap: true,
                  text: TextSpan(
                      text: "$label\n",
                      style: AppTextStyles.smallGrayTitleStyle,
                      children: [
                        TextSpan(
                          text: "$detail ",
                          style: AppTextStyles.generalLabelStyle,
                        )
                      ])),
            )
          ],
        ),
      ),
    );
  }
}
