import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/features/booking_history_details/presentation/cubit/cancel_booking_cubit.dart';
import 'package:make_my_trip/features/booking_history_details/presentation/widgets/booking_history_detail_body.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import '../../../../core/theme/make_my_trip_colors.dart';
import '../../../../utils/widgets/common_primary_button.dart';
import '../../../user_history/data/model/user_history_model.dart';

class BookingHistoryDetails extends StatelessWidget {
  BookingHistoryDetails({Key? key, required this.userHistoryModel})
      : super(key: key);
  UserHistoryModel userHistoryModel;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CancelBookingCubit, CancelBookingState>(
        builder: (context, state) {
      if (state is BookingsCancelled) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          elevation: 4,
          title: Column(
            children: [
              AspectRatio(
                aspectRatio: 1.6,
                child: Image.asset(
                  ImagePath.noRoomFound,
                ),
              ),
              30.verticalSpace,
              Text(
                StringConstants.bookingCancelledSuccessfully,
                style: const TextStyle(
                    color: MakeMyTripColors.accentColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              25.verticalSpace,
              SizedBox(
                width: double.infinity,
                child: CommonPrimaryButton(
                    text: "Ok",
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, RoutesName.home, (route) => false);
                    }),
              ),
            ],
          ),
        );
      } else if (state is BookingsCancellationFailure) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          elevation: 4,
          title: Column(
            children: [
              AspectRatio(
                aspectRatio: 1.6,
                child: Image.asset(
                  ImagePath.serverFailImage,
                ),
              ),
              30.verticalSpace,
              Text(
                StringConstants.cantCancelBooking,
                style: const TextStyle(
                    color: MakeMyTripColors.accentColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              25.verticalSpace,
              SizedBox(
                width: double.infinity,
                child: CommonPrimaryButton(
                    text: "Ok",
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, RoutesName.home, (route) => false);
                    }),
              ),
            ],
          ),
        );
      } else {
        return BookingHistoryDetailBody(userHistoryModel);
      }
    });
  }
}
