import 'package:flutter/material.dart';

import '../../../../core/theme/text_styles.dart';

class FilterTitleWidget extends StatelessWidget {
  const FilterTitleWidget({
    Key? key,
    required this.filterTitle,
  }) : super(key: key);

  final String filterTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        filterTitle,
        style: AppTextStyles.labelDetails
            .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }
}
