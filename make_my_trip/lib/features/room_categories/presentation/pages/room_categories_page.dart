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
  const RoomCategoriesPage({Key? key, required this.arg}) : super(key: key);
  final Map<String, dynamic> arg;

  @override
  Widget build(BuildContext context) {
    RoomCategoryModel? roomCategoryModel;
    return BlocConsumer<RoomCategoryCubit, BaseState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          Navigator.pushNamed(context, RoutesName.login,
              arguments: {"route_name": RoutesName.roomCategory});
        } else if (state is StateOnKnownToSuccess<RoomDataPostModel>) {
          Navigator.pushNamed(context, RoutesName.bookingPage,
              arguments: {"model": state.response});
        }
      },
      builder: (context, state) {
        if (state is StateOnKnownToSuccess<RoomCategoryModel>) {
          roomCategoryModel = state.response;
          if (roomCategoryModel!.superdeluxeRoomId!.isEmpty &&
              roomCategoryModel!.semideluxeRoomId!.isEmpty &&
              roomCategoryModel!.deluxeRoomId!.isEmpty) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Column(
                  children: [
                    Text(
                      StringConstants.roomCategoriesPageHeading,
                      style:
                          AppTextStyles.infoContentStyle.copyWith(fontSize: 18),
                    ),
                  ],
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  AspectRatio(
                    aspectRatio: 1.6,
                    child: Image.asset(
                      ImagePath.noRoomFound,
                    ),
                  ),
                  25.verticalSpace,
                  Text(
                    StringConstants.noRoomAvail,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: MakeMyTripColors.accentColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                ],
              ),
            );
          }
        } else if (state is StateLoading) {
          return const RoomCategoriesShimmerPage();
        } else if (state is StateErrorGeneral) {
          return CommonErrorWidget(
              imagePath: ImagePath.serverFailImage,
              title: StringConstants.serverFail,
              statusCode: "");
        }
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              StringConstants.roomCategoriesPageHeading,
              style: AppTextStyles.infoContentStyle.copyWith(fontSize: 18),
            ),
          ),
          body: BlocBuilder<SelectRoomCountCubit, BaseState>(
              builder: (context, state) {
            if (state is StateOnSuccess<SelectRoomCountState>) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 12, left: 12, top: 16),
                      child: Text(
                        roomCategoryModel!.hotelName ?? "Hotel Name",
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.infoContentStyle2.copyWith(
                            fontSize: 24, color: MakeMyTripColors.colorBlack),
                      ),
                    ),
                    RoomListWidget(
                        maxCount: roomCategoryModel!.deluxeRoomId!.length -
                            state.response.deluxValue,
                        hotelId: int.parse(roomCategoryModel!.hotelId!),
                        roomData: roomCategoryModel!.deluxe!,
                        roomList: roomCategoryModel!.deluxeRoomId!,
                        roomRemoveOnTap: () {
                          context.read<SelectRoomCountCubit>().removeRoomEvent(
                              roomCategoryModel!.deluxe!.roomType!,
                              state.response.deluxValue,
                              arg["noofrooms"]);
                        },
                        roomAddOnTap: () {
                          context.read<SelectRoomCountCubit>().addRoomEvent(
                              roomCategoryModel!.deluxe!.roomType!,
                              state.response.deluxValue,
                              roomCategoryModel!.deluxeRoomId!.length,
                              arg["noofrooms"]);
                        },
                        totalSelectedRoom: state.response.deluxValue,
                        cin: arg['cin'],
                        cout: arg['cout']),
                    RoomListWidget(
                        maxCount: roomCategoryModel!.semideluxeRoomId!.length -
                            state.response.semiDeluxValue,
                        hotelId: int.parse(roomCategoryModel!.hotelId!),
                        roomData: roomCategoryModel!.semideluxe!,
                        roomList: roomCategoryModel!.semideluxeRoomId!,
                        roomRemoveOnTap: () {
                          context.read<SelectRoomCountCubit>().removeRoomEvent(
                              roomCategoryModel!.semideluxe!.roomType!,
                              state.response.semiDeluxValue,
                              arg["noofrooms"]);
                        },
                        roomAddOnTap: () {
                          context.read<SelectRoomCountCubit>().addRoomEvent(
                              roomCategoryModel!.semideluxe!.roomType!,
                              state.response.semiDeluxValue,
                              roomCategoryModel!.semideluxeRoomId!.length,
                              arg["noofrooms"]);
                        },
                        totalSelectedRoom: state.response.semiDeluxValue,
                        cin: arg['cin'],
                        cout: arg['cout']),
                    RoomListWidget(
                        maxCount: roomCategoryModel!.superdeluxeRoomId!.length -
                            state.response.superDeluxValue,
                        hotelId: int.parse(roomCategoryModel!.hotelId!),
                        roomData: roomCategoryModel!.supedeluxe!,
                        roomList: roomCategoryModel!.superdeluxeRoomId!,
                        roomRemoveOnTap: () {
                          context.read<SelectRoomCountCubit>().removeRoomEvent(
                              roomCategoryModel!.supedeluxe!.roomType!,
                              state.response.superDeluxValue,
                              arg["noofrooms"]);
                        },
                        roomAddOnTap: () {
                          context.read<SelectRoomCountCubit>().addRoomEvent(
                              roomCategoryModel!.supedeluxe!.roomType!,
                              state.response.superDeluxValue,
                              roomCategoryModel!.superdeluxeRoomId!.length,
                              arg["noofrooms"]);
                        },
                        totalSelectedRoom: state.response.superDeluxValue,
                        cin: arg['cin'],
                        cout: arg['cout']),
                  ],
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
          bottomNavigationBar: BlocBuilder<SelectRoomCountCubit, BaseState>(
            builder: (context, state) {
              var price = 0;
              if (state is StateOnSuccess<SelectRoomCountState>) {
                if (state.response.deluxValue > 0) {
                  price += state.response.deluxValue *
                      roomCategoryModel!.deluxe!.price!;
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
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
                                    .copyWith(
                                        color: MakeMyTripColors.color70gray),
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
                                              roomCategoryModel!
                                                      .deluxe!.roomType!:
                                                  state.response.deluxValue,
                                              roomCategoryModel!
                                                      .semideluxe!.roomType!:
                                                  state.response.semiDeluxValue,
                                              roomCategoryModel!
                                                      .supedeluxe!.roomType!:
                                                  state
                                                      .response.superDeluxValue,
                                            },
                                            roomCategoryModel!,
                                            arg['adults']);
                                  }
                                },
                                disable: (state.response.totalRooms !=
                                    arg["noofrooms"]),
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
      },
    );
  }
}
