import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_categories_model.dart';
import 'package:make_my_trip/features/room_categories/presentation/cubit/room_category_cubit.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

class RoomListWidget extends StatelessWidget {
  RoomListWidget({Key? key, this.roomData}) : super(key: key);
  RoomData? roomData;
  bool isReadMore = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomCategoryCubit, BaseState>(
      builder: (context, state) {
        if (state is StateOnSuccess) {
          isReadMore = state.response;
        }
        return Padding(
          padding: const EdgeInsets.only(
              top: 12.0, left: 4.0, right: 4.0, bottom: 4.0),
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
                    "${roomData?.roomType} Room",
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
                              roomData?.description ?? "Description",
                              maxLines: (isReadMore) ? 10 : 3,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.justify,
                              style: AppTextStyles.labelDescriptionStyle
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  BlocProvider.of<RoomCategoryCubit>(context)
                                      .onReadMoreTap(isReadMore);
                                },
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
                            roomData?.images![0].imageUrl ?? ImagePath.demoroom,
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
                            roomData?.images![1].imageUrl ?? ImagePath.demoroom,
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
                            roomData!.features![0],
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
                            roomData!.features![1],
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
                            roomData!.features![2],
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
                            roomData!.features![3],
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
                          Text(
                            "₹ ${roomData!.price?.toString()} ",
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
      },
    );
  }
}
