import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/features/booking_history_details/presentation/cubit/cancel_booking_cubit.dart';
import 'package:make_my_trip/features/booking_history_details/presentation/widgets/booking_history_detail_body.dart';
import 'package:make_my_trip/features/user_history/presentation/cubit/user_history_cubit.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import '../../../../core/theme/make_my_trip_colors.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../utils/widgets/common_primary_button.dart';
import '../../../user_history/data/model/user_history_model.dart';

class BookingHistoryDetails extends StatelessWidget {
  const BookingHistoryDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<CancelBookingCubit, CancelBookingState>(
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
                  const Text(
                    "Cancelled Booking Successfuly",
                    style: TextStyle(
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
                  const Text(
                    "Error Occurred while cancelling booking please try after some times",
                    style: TextStyle(
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
            return const BookingHistoryDetailBody();
          }
        }
        );

  }
}
