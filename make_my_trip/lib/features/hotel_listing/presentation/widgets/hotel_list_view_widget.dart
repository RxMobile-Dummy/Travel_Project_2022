import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/hotel_listing/presentation/cubits/hotel_list_cubit.dart';
import 'package:make_my_trip/features/hotel_listing/presentation/cubits/hotel_list_state.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

class HotelListViewWidget extends StatelessWidget {
  const HotelListViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HotelListCubit>(context).getHotelListApi("del");
    return GestureDetector(
        onTap: () {
          Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.hotelDetail, (route) => true);
        },
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: BlocBuilder<HotelListCubit, HotelListState>(
              builder: (context, state) {
                if (state is GetData) {
                  var hotelList = state.GetList;
                  return ListView.separated(
                    itemCount: hotelList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var hotelData = hotelList[index];
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            child: SizedBox(
                              height: 200,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  hotelData.images!.last.imageUrl.toString(),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: Row(
                                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        flex: 4,
                                        child: Text(
                                          hotelData.hotelName.toString(),
                                          style: AppTextStyles.infoContentStyle,
                                        ),
                                      ),
                                      35.horizontalSpace,
                                      Flexible(
                                        flex: 1,
                                        child: Transform.scale(
                                          scale: 1.5,
                                          child: RatingBar.builder(
                                              initialRating: double.parse(
                                                  hotelData.rating.toString()),
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemSize: 10,
                                              itemCount: 5,
                                              itemPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0.3),
                                              itemBuilder: (context, _) =>
                                                  const Icon(
                                                    Icons.star,
                                                    color: MakeMyTripColors
                                                        .accentColor,
                                                    size: 10,
                                                  ),
                                              onRatingUpdate: (rating) {}),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                25.horizontalSpace
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 12.0, right: 12.0, top: 4.0, bottom: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: Text(
                                    hotelData.address!.addressLine.toString(),
                                    style: AppTextStyles.labelDetails,
                                  ),
                                ),
                                const Spacer(),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "₹ ${hotelData.price.toString()}",
                                        style: AppTextStyles.labelStyle2,
                                      ),
                                      const Text("Per Night",
                                          style: AppTextStyles.labelDetails)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          5.verticalSpace
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 10,
                        decoration: const BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: MakeMyTripColors.color90gray,
                            blurRadius: 5.0,
                          ),
                        ], color: MakeMyTripColors.color0gray),
                      );
                    },
                  );
                } else {
                  return const Text("Loading");
                }
              },
            )));
  }
}
