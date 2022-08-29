import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/hotel_detail/presentation/widgets/features_item_widget.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_category_model.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_data_booking_post_model.dart';
import 'package:make_my_trip/features/room_categories/presentation/cubit/room_category_cubit.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

class RoomListWidget extends StatelessWidget {
  RoomListWidget({
    Key? key,
    required this.hotelId,
    required this.roomData,
    required this.roomRemoveOnTap,
    required this.roomAddOnTap,
    required this.totalSelectedRoom,
    required this.roomList,
    required this.cin,
    required this.cout,
    required this.maxCount,
  }) : super(key: key);
  final List<dynamic> roomList;
  final int maxCount;
  final Deluxe roomData;
  final VoidCallback roomRemoveOnTap;
  final VoidCallback roomAddOnTap;
  final String cin;
  final String cout;
  int totalSelectedRoom;
  final int hotelId;
  var snackBar = const SnackBar(content: Text(StringConstants.noRoomSelect));
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomCategoryCubit, BaseState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(
              top: 6.0, left: 4.0, right: 4.0, bottom: 2.0),
          child: Card(
            elevation: 10, // Change this
            shadowColor: MakeMyTripColors.color10gray,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(
                    color: (roomList.isEmpty)
                        ? MakeMyTripColors.colorRed
                        : Colors.transparent)),
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
                                'room_list_model': roomData,
                                "context": context,
                                'cin': cin,
                                'cout': cout
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
                                placeholder: ImagePath.placeHolderImage,
                                image: roomData.image!.isNotEmpty
                                    ? (roomData.image![0].imageUrl ??
                                        ImagePath.demoroom)
                                    : ImagePath.demoroom,
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Image.asset(ImagePath.placeHolderImage,
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
                                placeholder: ImagePath.placeHolderImage,
                                image: roomData.image!.isNotEmpty
                                    ? (roomData.image![1].imageUrl ??
                                        ImagePath.demoroom)
                                    : ImagePath.demoroom,
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Image.asset(ImagePath.placeHolderImage,
                                      fit: BoxFit.fitWidth);
                                })),
                      ),
                      8.horizontalSpace,
                    ],
                  ),
                  15.verticalSpace,
                  Wrap(
                    children: List.generate(
                      roomData.features!.length,
                      (index) => FeaturesItemWidget(
                        text: roomData.features!.isNotEmpty
                            ? roomData.features![index]
                            : "",
                      ),
                    ),
                  ),
                  12.verticalSpace,
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      (maxCount > 0)
                          ? "Only $maxCount ${(maxCount > 1) ? "rooms" : "room"} left!!"
                          : "No Rooms available!",
                      style: const TextStyle(color: MakeMyTripColors.colorRed),
                    ),
                  ),
                  12.verticalSpace,
                  Container(
                    height: 55,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: MakeMyTripColors.color10gray,
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
                                    color: MakeMyTripColors.color50gray,
                                  ),
                                  Icon(
                                    Icons.remove,
                                    size: 20,
                                    color: MakeMyTripColors.colorWhite,
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
                                    color: MakeMyTripColors.color50gray,
                                  ),
                                  Icon(
                                    Icons.add,
                                    size: 20,
                                    color: MakeMyTripColors.colorWhite,
                                  ),
                                ]),
                          ),
                          const Spacer(),
                          Text(
                            "₹ ${(roomData.price!).toString()} ",
                            style: AppTextStyles.infoContentStyle
                                .copyWith(fontSize: 18),
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
