import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/hotel_detail/presentation/widgets/features_item_widget.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_categories_model.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_data_booking_post_model.dart';
import 'package:make_my_trip/features/room_categories/presentation/cubit/room_category_cubit.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

class RoomListWidget extends StatelessWidget {
   RoomListWidget({Key? key,
    required this.hotelId,
    required this.roomData,
    required this.roomRemoveOnTap,
    required this.roomAddOnTap,
    required this.totalSelectedRoom,
    required this.roomList,
    required this.cin,
    required this.cout,
  }) : super(key: key);
  final List<RoomType> roomList;
  final RoomType roomData;
  final VoidCallback roomRemoveOnTap;
  final VoidCallback roomAddOnTap;
  final String cin;
  final String cout;
  int totalSelectedRoom;
  final int hotelId;

  @override
  Widget build(BuildContext context) {
    var snackBar =
        SnackBar(content: Text('No Room Selected, Pls First Select Room'));
    return BlocBuilder<RoomCategoryCubit, BaseState>(
  builder: (context, state) {
    return Padding(
          padding: const EdgeInsets.only(
              top: 4.0, left: 4.0, right: 4.0, bottom: 2.0),
          child: Card(
            elevation: 50, // Change this
            shadowColor: MakeMyTripColors.color10gray,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${roomData.roomType} Room",
                        style: AppTextStyles.unselectedLabelStyle.copyWith(
                            fontSize: 22, fontWeight: FontWeight.w800),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RoutesName.roomDetail,
                              arguments: {
                                'hotel_id': hotelId,
                                'room_id': roomData.roomId,
                                'no_of_room': totalSelectedRoom,
                                'room_list_model': roomList,
                                "context": context,
                                'cin':cin,
                                'cout':cout
                              });
                        },
                        child: Text(
                          StringConstants.roomMoreDetails,
                          style: AppTextStyles.infoContentStyle2
                              .copyWith(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  8.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              roomData.description ?? "Description",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.justify,
                              style: AppTextStyles.labelDescriptionStyle
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  8.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: FadeInImage.assetNetwork(
                                width: double.infinity / 2,
                                height: 150,
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                                placeholder: 'assets/img/placeholder.png',
                                image: roomData.image!.isNotEmpty
                                    ? (roomData.image![0].imageUrl ??
                                        ImagePath.demoroom)
                                    : ImagePath.demoroom,
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Image.asset(
                                      'assets/img/placeholder.png',
                                      fit: BoxFit.fitWidth);
                                })),
                      ),
                      8.horizontalSpace,
                      Expanded(
                        flex: 1,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: FadeInImage.assetNetwork(
                                width: double.infinity / 2,
                                height: 150,
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                                placeholder: 'assets/img/placeholder.png',
                                image: roomData.image!.isNotEmpty
                                    ? (roomData.image![1].imageUrl ??
                                        ImagePath.demoroom)
                                    : ImagePath.demoroom,
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Image.asset(
                                      'assets/img/placeholder.png',
                                      fit: BoxFit.fitWidth);
                                })),
                      ),
                      8.horizontalSpace,
                    ],
                  ),
                  15.verticalSpace,
                  Wrap(
                    children: [
                      FeaturesItemWidget(
                        text: roomData.features!.isNotEmpty
                            ? roomData.features![0]
                            : "",
                      ),
                      FeaturesItemWidget(
                        text: roomData.features!.isNotEmpty
                            ? roomData.features![1]
                            : "",
                      ),
                      15.verticalSpace,
                      FeaturesItemWidget(
                        text: roomData.features!.isNotEmpty
                            ? roomData.features![2]
                            : "",
                      ),
                      FeaturesItemWidget(
                        text: roomData.features!.isNotEmpty
                            ? roomData.features![3]
                            : "",
                      ),
                    ],
                  ),
                  12.verticalSpace,
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.grey[200],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 2.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: roomRemoveOnTap,
                            child: Stack(
                                alignment: AlignmentDirectional.center,
                                children: const [
                                  Icon(
                                    Icons.square_rounded,
                                    size: 25,
                                    color: Colors.grey,
                                  ),
                                  Icon(
                                    Icons.remove,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ]),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Text(
                              totalSelectedRoom.toString(),
                              style: AppTextStyles.infoContentStyle,
                            ),
                          ),
                          GestureDetector(
                            onTap: roomAddOnTap,
                            child: Stack(
                                alignment: AlignmentDirectional.center,
                                children: const [
                                  Icon(
                                    Icons.square_rounded,
                                    size: 25,
                                    color: Colors.grey,
                                  ),
                                  Icon(
                                    Icons.add,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ]),
                          ),
                          const Spacer(),
                          Text(
                            "₹ ${(roomData.price! * (totalSelectedRoom > 1 ? totalSelectedRoom : 1)).toString()} ",
                            style: AppTextStyles.infoContentStyle
                                .copyWith(fontSize: 16),
                          ),
                          const Spacer(),
                           ElevatedButton(
                              onPressed: () {
                                if (totalSelectedRoom > 0) {
                                  var searchState = context.read<RoomCategoryCubit>().state;
                                  if (searchState is Unauthenticated) {
                                    Navigator.popAndPushNamed(context, RoutesName.login,arguments: {"route_name":RoutesName.roomCategory});
                                  } if (state is StateOnKnownToSuccess<RoomDataPostModel>) {
                                    Navigator.pushNamed(
                                        context, RoutesName.bookingPage,arguments: {"model":state.response});
                                  }else {
                                    BlocProvider.of<RoomCategoryCubit>(context).goToBooking(hotelId,cin, cout, totalSelectedRoom,roomList);
                                  }
                                } else {
                                  (ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: totalSelectedRoom > 0
                                      ? MakeMyTripColors.colorBlue
                                      : MakeMyTripColors.color30gray,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  )),
                              child: Text(
                                StringConstants.roomSelectButtonTxt,
                                style: AppTextStyles.infoContentStyle
                                    .copyWith(fontSize: 14),
                              ),
                            ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },

);
  }
}