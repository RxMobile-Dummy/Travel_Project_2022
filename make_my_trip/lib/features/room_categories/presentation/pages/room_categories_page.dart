import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_categories_model.dart';
import 'package:make_my_trip/features/room_categories/presentation/cubit/room_category_cubit.dart';
import 'package:make_my_trip/features/room_categories/presentation/cubit/select_room_count.dart';
import 'package:make_my_trip/features/room_categories/presentation/pages/room_categories_shimmer_page.dart';
import 'package:make_my_trip/features/room_categories/presentation/widgets/room_list_widget.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';

class RoomCategoriesPage extends StatelessWidget {
  RoomCategoriesPage({Key? key, required this.arg}) : super(key: key);
  final Map<String, dynamic> arg;

  @override
  Widget build(BuildContext context) {
    RoomCategoryModel? roomCategoryModel;
    return BlocBuilder<RoomCategoryCubit, BaseState>(builder: (context, state) {
      if (state is StateOnKnownToSuccess<RoomCategoryModel>) {
        print(state.response);
        roomCategoryModel = state.response;
        if (roomCategoryModel!.superDeluxe!.isEmpty &&
            roomCategoryModel!.semiDeluxe!.isEmpty &&
            roomCategoryModel!.deluxe!.isEmpty) {
          return Center(
            child: Text('No Room Availble In Your CheckIn Date'),
          );
        }
      } else if (state is StateLoading) {
        return RoomCategoriesShimmerPage();
      }
      return Scaffold(
          backgroundColor: MakeMyTripColors.color30gray,
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringConstants.roomCategoriesPageHeading,
                  style: AppTextStyles.infoContentStyle,
                ),
                Text(
                  roomCategoryModel!.hotelName ?? "Hotel Name",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.infoContentStyle2.copyWith(fontSize: 18),
                ),
              ],
            ),
          ),
          body: BlocBuilder<SelectRoomCountCubit, BaseState>(
              builder: (context, state) {
            if (state is StateOnSuccess<SelectRoomCountState>) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    roomCategoryModel!.deluxe!.length > 0
                        ? RoomListWidget(
                            hotelId: int.parse(roomCategoryModel!.hotelId!),
                            roomData: roomCategoryModel!.deluxe![0],
                            roomList:roomCategoryModel!.deluxe!,
                            roomRemoveOnTap: () {
                              context
                                  .read<SelectRoomCountCubit>()
                                  .removeRoomEvent(
                                      roomCategoryModel!.deluxe![0].roomType!,
                                      state.response.deluxValue);
                            },
                            roomAddOnTap: () {
                              context.read<SelectRoomCountCubit>().addRoomEvent(
                                  roomCategoryModel!.deluxe![0].roomType!,
                                  state.response.deluxValue,
                                  roomCategoryModel!.deluxe!.length);
                            },
                            totalSelectedRoom: state.response.deluxValue,

                          )
                        : SizedBox(),
                    roomCategoryModel!.semiDeluxe!.length > 0
                        ? RoomListWidget(
                            hotelId: int.parse(roomCategoryModel!.hotelId!),
                            roomData: roomCategoryModel!.semiDeluxe![0],
                      roomList:roomCategoryModel!.semiDeluxe!,
                            roomRemoveOnTap: () {
                              print(state.response);
                              context
                                  .read<SelectRoomCountCubit>()
                                  .removeRoomEvent(
                                      roomCategoryModel!
                                          .semiDeluxe![0].roomType!,
                                      state.response.semiDeluxValue);
                            },
                            roomAddOnTap: () {
                              context.read<SelectRoomCountCubit>().addRoomEvent(
                                  roomCategoryModel!.semiDeluxe![0].roomType!,
                                  state.response.semiDeluxValue,
                                  roomCategoryModel!.semiDeluxe!.length);
                            },
                            totalSelectedRoom: state.response.semiDeluxValue,

                          )
                        : SizedBox(),
                    roomCategoryModel!.superDeluxe!.length > 0
                        ? RoomListWidget(
                            hotelId: int.parse(roomCategoryModel!.hotelId!),
                            roomData: roomCategoryModel!.superDeluxe![0],
                      roomList:roomCategoryModel!.superDeluxe!,
                            roomRemoveOnTap: () {
                              context
                                  .read<SelectRoomCountCubit>()
                                  .removeRoomEvent(
                                      roomCategoryModel!
                                          .superDeluxe![0].roomType!,
                                      state.response.superDeluxValue);
                            },
                            roomAddOnTap: () {
                              context.read<SelectRoomCountCubit>().addRoomEvent(
                                  roomCategoryModel!.superDeluxe![0].roomType!,
                                  state.response.superDeluxValue,
                                  roomCategoryModel!.superDeluxe!.length);
                            },
                            totalSelectedRoom: state.response.superDeluxValue,

                          )
                        : SizedBox(),
                  ],
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          }));
    });
  }
}
