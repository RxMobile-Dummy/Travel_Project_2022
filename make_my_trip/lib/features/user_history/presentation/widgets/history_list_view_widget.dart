import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/user_history/data/model/user_history_model.dart';
import 'package:make_my_trip/features/user_history/presentation/cubit/user_history_cubit.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

import '../../../booking_history_details/presentation/pages/booking_history_detail_page.dart';

class HistoryListViewWidget extends StatelessWidget {
  HistoryListViewWidget({Key? key, required this.userHistoryModel})
      : super(key: key);

  UserHistoryModel userHistoryModel;
  Random rnd = Random();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Card(
        elevation: 4,
        color: MakeMyTripColors.color10gray,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              child: SizedBox(
                height: 100,
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: FadeInImage.assetNetwork(
                      placeholder: ImagePath.placeHolderImage,
                      image: userHistoryModel.images!.first.imageUrl.toString(),
                      fit: BoxFit.fill,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(ImagePath.placeHolderImage,
                            fit: BoxFit.fitWidth);
                      }),
                ),
              ),
            ),
            4.horizontalSpace,
            Expanded(
              flex: 5,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                      context, RoutesName.bookingHistoryDetailPage);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    12.verticalSpace,
                    Text(
                      userHistoryModel.hotelName.toString(),
                      style: AppTextStyles.infoContentStyle,
                    ),
                    6.verticalSpace,
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 16,
                        ),
                        Expanded(
                          child: Text(
                            userHistoryModel.address!.addressLine.toString(),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        '₹ ${userHistoryModel.price.toString()}',
                        style:
                            AppTextStyles.infoLabelStyle.copyWith(fontSize: 14),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            '${userHistoryModel.checkingDate!.substring(0, userHistoryModel.checkingDate!.indexOf('T'))} - ${userHistoryModel.checkoutDate!.substring(0, userHistoryModel.checkoutDate!.indexOf('T'))}',
                            style: AppTextStyles.infoLabelStyle
                                .copyWith(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
