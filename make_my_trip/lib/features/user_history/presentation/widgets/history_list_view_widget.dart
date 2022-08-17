import 'dart:math';

import 'package:flutter/material.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

import '../../data/model/user_history_model.dart';


class HistoryListViewWidget extends StatelessWidget {
  HistoryListViewWidget({Key? key, required this.userHistoryModel})
      : super(key: key);

  UserHistoryModel userHistoryModel;
  Random rnd = Random();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        elevation: 4,
        color: MakeMyTripColors.color10gray,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Stack(
          children: [
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  child: SizedBox(
                    height: 120,
                    width: 120,
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
                          context, RoutesName.bookingHistoryDetailPage,arguments: userHistoryModel);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        22.verticalSpace,
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
            userHistoryModel.status=="cancel"?Positioned(
              top: 0,
              right: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                decoration: const BoxDecoration(
                    color: MakeMyTripColors.colorRedDark,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ) // green shaped
                ),
                child: Text("CANCELLED",style: AppTextStyles.infoContentStyle3.copyWith(fontSize: 11),),
              ),
            ):const SizedBox()
          ],
        ),
      ),
    );
  }
}
