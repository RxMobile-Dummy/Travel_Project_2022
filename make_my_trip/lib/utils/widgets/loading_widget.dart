import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const CircularProgressIndicator(
        strokeWidth: 5,
        color: MakeMyTripColors.accentColor,
      ),
    );
  }
}
