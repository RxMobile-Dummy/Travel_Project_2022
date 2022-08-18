import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:make_my_trip_admin_panel/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip_admin_panel/core/theme/text_styles.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/HotelModels.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/hotel_model.dart';
import 'package:make_my_trip_admin_panel/utils/extensions/sizedbox/sizedbox_extension.dart';
class HotelListViewWidget extends StatelessWidget {
  HotelListViewWidget({Key? key, required this.hotel})
      : super(key: key);
  HotelModels hotel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {},
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 2.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              hotel.hotelName.toString(),
                              style: AppTextStyles.infoContentStyle,
                            ),
                          ),
                          10.horizontalSpace,
                          Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Transform.scale(
                              scale: 1.5,
                              child: RatingBar.builder(
                                  initialRating: double.parse(
                                      hotel.rating.toString()),
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemSize: 10,
                                  itemCount: 5,
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: MakeMyTripColors.accentColor,
                                    size: 10,
                                  ),
                                  onRatingUpdate: (rating) {}),
                            ),
                          ),
                        ])),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          hotel.address!.addressLine.toString(),
                            style: AppTextStyles.labelDetails,
                            overflow: TextOverflow.ellipsis),
                      ),
                      10.horizontalSpace,
                      Text(
                        "₹ ${hotel.price}",
                        style: AppTextStyles.labelDetails,
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
