import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/hotel_listing/data/models/hotel_list_model.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

class HotelListViewWidget extends StatelessWidget {
  HotelListViewWidget({Key? key, required this.hotelListModel})
      : super(key: key);
  HotelListModel hotelListModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, RoutesName.hotelDetail,
              arguments: {"hotel_id": hotelListModel.id});
        },
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 6.0),
                  child: SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: FadeInImage.assetNetwork(
                        placeholder: ImagePath.placeHolderImage,
                        image:hotelListModel.images![0].imageUrl.toString(),
                        fit: BoxFit.fill,
                          imageErrorBuilder:
                              (context, error, stackTrace) {
                            return Image.asset(
                                ImagePath.placeHolderImage,
                                fit: BoxFit.fitWidth);
                          }
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 2.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              hotelListModel.hotelName.toString(),
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
                                      hotelListModel.rating.toString()),
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
                            hotelListModel.address!.addressLine.toString(),
                            style: AppTextStyles.labelDetails,
                            overflow: TextOverflow.ellipsis),
                      ),
                      10.horizontalSpace,
                      Text(
                        "₹ ${hotelListModel.price}",
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
