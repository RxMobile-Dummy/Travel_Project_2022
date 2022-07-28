import 'dart:math';

import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/user_history/data/model/user_history_model.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

class HistoryListViewWidget extends StatelessWidget {
  HistoryListViewWidget({Key? key, required this.userHistoryModel})
      : super(key: key);

  UserHistoryModel userHistoryModel;
  Random rnd =  Random();

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
            Expanded(
              flex: 2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: SizedBox(
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: FadeInImage.assetNetwork(
                        placeholder: 'assets/img/placeholder.png',
                        image:userHistoryModel.images![rnd.nextInt(userHistoryModel.images!.length)].imageUrl.toString(),
                        fit: BoxFit.fill,
                        imageErrorBuilder:
                            (context, error, stackTrace) {
                          return Image.asset(
                              'assets/img/placeholder.png',
                              fit: BoxFit.fitWidth);
                        }),
                  ),
                ),
              ),
            ),
            4.horizontalSpace,
            Expanded(
              flex: 5,
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
                          flex: 3,
                          child: Text(userHistoryModel.address!.addressLine
                              .toString(), maxLines: 2)),
                      const Spacer(),
                      Flexible(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              border: Border.all(),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(
                                  '₹ ${userHistoryModel.price.toString()}',
                                  style: AppTextStyles.infoLabelStyle
                                      .copyWith(fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      10.horizontalSpace,
                    ],
                  ),
                  4.verticalSpace,
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            '${userHistoryModel.checkingDate!.substring(0, userHistoryModel.checkingDate!.indexOf('T'))} - ${userHistoryModel.checkoutDate!.substring(0, userHistoryModel.checkoutDate!.indexOf('T'))}',
                            style: AppTextStyles.infoLabelStyle
                                .copyWith(fontSize: 12),
                          ),
                        ),
                      ),
                      40.verticalSpace,
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
