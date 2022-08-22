import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/room_categories/presentation/cubit/room_category_cubit.dart';
import 'package:make_my_trip/features/room_categories/presentation/cubit/select_room_count.dart';
import 'package:make_my_trip/features/room_categories/presentation/pages/room_categories_shimmer_page.dart';
import 'package:make_my_trip/features/room_categories/presentation/widgets/room_list_widget.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:make_my_trip/utils/widgets/common_error_widget.dart';
import 'package:make_my_trip/utils/widgets/common_primary_button.dart';

import '../../../../core/navigation/route_info.dart';
import '../../data/model/room_category_model.dart';
import '../../data/model/room_data_booking_post_model.dart';

class RoomCategoriesPage extends StatelessWidget {
  RoomCategoriesPage({Key? key, required this.arg}) : super(key: key);
  final Map<String, dynamic> arg;
  Map<Deluxe, List<dynamic>> sortedList = {};
  @override
  Widget build(BuildContext context) {
    RoomCategoryModel? roomCategoryModel;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringConstants.roomCategoriesPageHeading,
          style: AppTextStyles.infoContentStyle.copyWith(fontSize: 18),
        ),
      ),
      body: BlocConsumer<RoomCategoryCubit, BaseState>(
          listener: (context, state) {
        if (state is Unauthenticated) {
          Navigator.pushNamed(context, RoutesName.login,
              arguments: {"route_name": RoutesName.roomCategory});
        } else if (state is StateOnKnownToSuccess<RoomDataPostModel>) {
          Navigator.pushNamed(context, RoutesName.bookingPage,
              arguments: {"model": state.response});
        }
      }, builder: (context, state) {
        if (state is StateErrorGeneral) {
          return CommonErrorWidget(
              imagePath: ImagePath.serverFailImage,
              title: StringConstants.serverFail,
              statusCode: "");
        } else if (state is StateOnKnownToSuccess<RoomCategoryModel>) {
          roomCategoryModel = state.response;
          sortedList = {
            roomCategoryModel!.deluxe!: roomCategoryModel!.deluxeRoomId!,
            roomCategoryModel!.semideluxe!:
                roomCategoryModel!.semideluxeRoomId!,
            roomCategoryModel!.supedeluxe!:
                roomCategoryModel!.superdeluxeRoomId!
          };

          return BlocBuilder<SelectRoomCountCubit, BaseState>(
              builder: (context, state) {
            if (state is StateOnSuccess<SelectRoomCountState>) {
              return SingleChildScrollView(
                  child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 12, left: 12, top: 16),
                    child: Text(
                      roomCategoryModel!.hotelName!,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.infoContentStyle2.copyWith(
                          fontSize: 24, color: MakeMyTripColors.colorBlack),
                    ),
                  ),
                  Column(
                      children: sortedList.entries.map((e) {
                    int roomCount =
                        ((e.key.roomType! == StringConstants.deluxType)
                            ? state.response.deluxValue
                            : (e.key.roomType == StringConstants.semiDeluxType)
                                ? state.response.semiDeluxValue
                                : state.response.superDeluxValue);
                    return RoomListWidget(
                        maxCount: (sortedList[e.key]!.length) - roomCount,
                        hotelId: int.parse(roomCategoryModel!.hotelId!),
                        roomData: e.key,
                        roomList: sortedList[e.key]!,
                        roomRemoveOnTap: () {
                          context.read<SelectRoomCountCubit>().removeRoomEvent(
                              e.key.roomType!, roomCount, arg["noofrooms"]);
                        },
                        roomAddOnTap: () {
                          context.read<SelectRoomCountCubit>().addRoomEvent(
                              e.key.roomType!,
                              roomCount,
                              sortedList[e.key]!.length,
                              arg["noofrooms"]);
                        },
                        totalSelectedRoom: roomCount,
                        cin: arg['cin'],
                        cout: arg['cout']);
                  }).toList()),
                ],
              ));
            } else {
              return const RoomCategoriesShimmerPage();
            }
          });
        } else {
          return const RoomCategoriesShimmerPage();
        }
      }),
      bottomNavigationBar: BlocBuilder<SelectRoomCountCubit, BaseState>(
        builder: (context, state) {
          var price = 0;
          if (state is StateOnSuccess<SelectRoomCountState>) {
            if (state.response.deluxValue > 0) {
              price +=
                  state.response.deluxValue * roomCategoryModel!.deluxe!.price!;
            }
            if (state.response.semiDeluxValue > 0) {
              price += state.response.semiDeluxValue *
                  roomCategoryModel!.semideluxe!.price!;
            }
            if (state.response.superDeluxValue > 0) {
              price += state.response.superDeluxValue *
                  roomCategoryModel!.supedeluxe!.price!;
            }

            return SafeArea(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "₹ ${price} ",
                            style: AppTextStyles.smallBlackTitleStyle
                                .copyWith(fontSize: 22),
                          ),
                          Text(
                            'Per night for ${arg["noofrooms"]} Rooms',
                            style: AppTextStyles.smallGrayTitleStyle
                                .copyWith(color: MakeMyTripColors.color70gray),
                          ),
                        ],
                      ),
                      SizedBox(
                          width: 150,
                          child: CommonPrimaryButton(
                            text: StringConstants.book,
                            onTap: () {
                              if (state.response.totalRooms ==
                                  arg["noofrooms"]) {
                                BlocProvider.of<RoomCategoryCubit>(context)
                                    .goToBooking(
                                        roomCategoryModel!.hotelId!,
                                        arg["cin"],
                                        arg["cout"],
                                        arg["noofrooms"],
                                        {
                                          roomCategoryModel!.deluxe!.roomType!:
                                              state.response.deluxValue,
                                          roomCategoryModel!
                                                  .semideluxe!.roomType!:
                                              state.response.semiDeluxValue,
                                          roomCategoryModel!
                                                  .supedeluxe!.roomType!:
                                              state.response.superDeluxValue,
                                        },
                                        roomCategoryModel!,
                                        arg['adults']);
                              }
                            },
                            disable:
                                (state.response.totalRooms != arg["noofrooms"]),
                          ))
                    ],
                  )),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
