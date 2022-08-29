import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:make_my_trip_admin_panel/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip_admin_panel/core/theme/text_styles.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/HotelModels.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/presentation/cubit/hotel_cubit.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/presentation/pages/add_hotels.dart';
import 'package:make_my_trip_admin_panel/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:make_my_trip_admin_panel/utils/widgets/common_primary_button.dart';

import '../../../../utils/constants/image_path.dart';

typedef callhotel = Function(String id);

class HotelListViewWidget extends StatelessWidget {
  HotelListViewWidget({Key? key, required this.hotel, required this.callback})
      : super(key: key);
  HotelModels hotel;
  callhotel callback;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {},
        child:
            Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                                              color:
                                                  MakeMyTripColors.accentColor,
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
                              child: Text(hotel.address!.addressLine.toString(),
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
                      // Container(
                      //   height: size.height>300?size.height*0.15:size.width*0.30,
                      //   width: size.width*0.5,
                      //   child: GridView.builder(
                      //     itemCount: hotel.images!.length,
                      //     itemBuilder: (BuildContext context, int index) {
                      //       return Padding(
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: Flexible(
                      //                   child: ClipRRect(
                      //                       borderRadius: BorderRadius.circular(12),
                      //                       child: FadeInImage.assetNetwork(
                      //                         placeholder: ImagePath.placeholder,
                      //                         image: hotel.images![index].imageUrl!,
                      //                         width: size.width*0.1,
                      //                         height: size.height*0.2,
                      //                         fit: BoxFit.cover,
                      //                         imageErrorBuilder:
                      //                             (context, error, stackTrace) {
                      //                           return Image.asset(
                      //                             hotel.images![index].imageUrl!,
                      //                             fit: BoxFit.cover,
                      //                             width: 36,
                      //                             height: 36,
                      //                           );
                      //                         },
                      //                       )),
                      //                 ),
                      //               );
                      //     }, gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      //       maxCrossAxisExtent: 200,
                      //       childAspectRatio: 3 / 2,
                      //       crossAxisSpacing: 10,
                      //       mainAxisSpacing: 10),
                      //
                      //   ),
                      // ),
                      Wrap(
                        children: List.generate(hotel.images!.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Flexible(
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: ImagePath.placeholder,
                                    image: hotel.images![index].imageUrl!,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Image.asset(
                                        hotel.images![index].imageUrl!,
                                        fit: BoxFit.cover,
                                        width: 36,
                                        height: 36,
                                      );
                                    },
                                  )),
                            ),
                          );
                        }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CommonPrimaryButton(
                              text: "Delete",
                              onTap: () {
                                BlocProvider.of<HotelCubit>(context)
                                    .deleteHotels(hotel.id.toString());
                              },
                              backColor: Colors.blue,
                              disable: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CommonPrimaryButton(
                              text: "Update",
                              onTap: () {
                                callback(hotel.id.toString());
                              },
                              backColor: Colors.blue,
                              disable: false,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
        ),
    );
  }
}
