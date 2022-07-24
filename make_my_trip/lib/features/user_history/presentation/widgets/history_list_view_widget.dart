import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/user_history/data/model/user_history_model.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

class HistoryListViewWidget extends StatelessWidget {
  HistoryListViewWidget({Key? key, required this.userHistoryModel})
      : super(key: key);

  UserHistoryModel userHistoryModel;

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
                    child: Image.network(
                        userHistoryModel.images![0].imageUrl.toString(),
                        fit: BoxFit.fill),
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
                  8.verticalSpace,
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16,
                      ),
                      Expanded(
                          flex: 3,
                          child: Text(userHistoryModel.address!.addressLine
                              .toString())),
                      const Spacer(),
                      Expanded(
                        flex: 2,
                        child: Card(
                          elevation: 3,
                          color: MakeMyTripColors.accentColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Center(
                              child: Text(
                                'RS ${userHistoryModel.price.toString()}',
                                style: AppTextStyles.infoLabelStyle
                                    .copyWith(fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  8.verticalSpace,
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(StringConstants.totalBookingDays,
                              style: AppTextStyles.infoLabelStyle
                                  .copyWith(fontSize: 12)),
                        ),
                      ),
                      8.horizontalSpace,
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
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
