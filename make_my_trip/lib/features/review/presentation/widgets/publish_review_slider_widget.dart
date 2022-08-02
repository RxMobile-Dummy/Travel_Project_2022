import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';

typedef StringCallback = void Function(double val);

class PublishReviewSliderWidget extends StatelessWidget {
  const PublishReviewSliderWidget(
      {Key? key,
      required this.fieldName,
      required this.value,
      required this.context,
      required this.callback})
      : super(key: key);

  final StringCallback callback;
  final String fieldName;
  final double value;
  final BuildContext context;

  @override
  Widget build(context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                fieldName,
                style: AppTextStyles.labelDescriptionStyle,
              ),
              Text(
                value.toString(),
                style: AppTextStyles.infoContentStyle,
              )
            ],
          ),
        ),
        Slider(
          value: value,
          min: 0.0,
          max: 5.0,
          divisions: 5,
          thumbColor: MakeMyTripColors.colorWhite,
          activeColor: MakeMyTripColors.accentColor,
          inactiveColor: MakeMyTripColors.color10gray,
          onChanged: callback,
        )
      ],
    );
  }
}
