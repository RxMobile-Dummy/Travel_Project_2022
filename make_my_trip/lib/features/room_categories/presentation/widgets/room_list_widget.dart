import 'package:flutter/material.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_categories_model.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

class RoomListWidget extends StatelessWidget {
  const RoomListWidget(
      {Key? key,
      required this.roomData,
      required this.roomRemoveOnTap,
      required this.roomAddOnTap,
      required this.totalSelectedRoom,
      required this.isReadMore,
      required this.isRoomOnTap})
      : super(key: key);
  final RoomType roomData;
  final VoidCallback roomRemoveOnTap;
  final VoidCallback roomAddOnTap;
  final VoidCallback isRoomOnTap;
  final int totalSelectedRoom;
  final bool isReadMore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 12.0, left: 4.0, right: 4.0, bottom: 4.0),
      child: Card(
        elevation: 50, // Change this
        shadowColor: MakeMyTripColors.color10gray,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${roomData.roomType} Room",
                style: AppTextStyles.unselectedLabelStyle
                    .copyWith(fontSize: 22, fontWeight: FontWeight.w800),
              ),
              8.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          roomData.description ?? "Description",
                          maxLines: (isReadMore) ? 10 : 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                          style: AppTextStyles.labelDescriptionStyle
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: isRoomOnTap,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                (isReadMore)
                                    ? StringConstants.readLessTxt
                                    : StringConstants.readMoreTxt,
                                style: AppTextStyles.infoContentStyle2,
                              ),
                            ),
                          ),
                        )
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
                      child: Image.network(
                        roomData.image![0].imageUrl ?? ImagePath.demoroom,
                        width: double.infinity / 2,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  8.horizontalSpace,
                  Expanded(
                    flex: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        roomData.image![1].imageUrl ?? ImagePath.demoroom,
                        width: double.infinity / 2,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  8.horizontalSpace,
                ],
              ),
              15.verticalSpace,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.star,
                    size: 18,
                  ),
                  Expanded(
                      flex: 5,
                      child: Text(
                        roomData.features![0],
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.infoContentStyle
                            .copyWith(fontSize: 16),
                      )),
                  const Icon(
                    Icons.star,
                    size: 18,
                  ),
                  Expanded(
                      flex: 5,
                      child: Text(
                        roomData.features![1],
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.infoContentStyle
                            .copyWith(fontSize: 16),
                      )),
                ],
              ),
              6.verticalSpace,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.star,
                    size: 18,
                  ),
                  Expanded(
                      flex: 5,
                      child: Text(
                        roomData.features![2],
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.infoContentStyle
                            .copyWith(fontSize: 16),
                      )),
                  const Icon(
                    Icons.star,
                    size: 18,
                  ),
                  Expanded(
                      flex: 5,
                      child: Text(
                        roomData.features![3],
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.infoContentStyle
                            .copyWith(fontSize: 16),
                      )),
                ],
              ),
              5.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, RoutesName.roomDetail, (route) => true);
                    },
                    child: Text(
                      StringConstants.roomMoreDetails,
                      style: AppTextStyles.infoContentStyle2
                          .copyWith(fontSize: 14),
                    ),
                  ),
                ],
              ),
              5.verticalSpace,
              Container(
                height: 40,
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
                                size: 20,
                                color: Colors.grey,
                              ),
                              Icon(
                                Icons.remove,
                                size: 15,
                                color: Colors.white,
                              ),
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
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
                                size: 20,
                                color: Colors.grey,
                              ),
                              Icon(
                                Icons.add,
                                size: 15,
                                color: Colors.white,
                              ),
                            ]),
                      ),
                      const Spacer(),
                      Text(
                        "₹ ${roomData.price?.toString()} ",
                        style: AppTextStyles.infoContentStyle
                            .copyWith(fontSize: 14),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          )),
                          child: Text(
                            StringConstants.roomSelectButtonTxt,
                            style: AppTextStyles.infoContentStyle
                                .copyWith(fontSize: 14),
                          ),
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
  }
}
