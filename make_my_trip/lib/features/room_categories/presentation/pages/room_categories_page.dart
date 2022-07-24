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
  const RoomCategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomCategoryCubit, BaseState>(builder: (context, state) {
      if (state is StateOnKnownToSuccess<RoomCategoryModel>) {
        print(state.response);
        RoomCategoryModel roomCategoryModel = state.response;
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
                    roomCategoryModel.hotelName!,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style:
                    AppTextStyles.infoContentStyle2.copyWith(fontSize: 18),
                  ),
                ],
              ),
            ),
            body: BlocBuilder<SelectRoomCountCubit, BaseState>(
              builder: (context, state) {
                print(roomCategoryModel.deluxe!.length);
                print(roomCategoryModel.semiDeluxe!.length);
                print(roomCategoryModel.superDeluxe!.length);
                if (state is StateOnSuccess<SelectRoomCountState>) {
                  return ListView(
                    children: [
                      roomCategoryModel.deluxe!.isNotEmpty
                          ? RoomListWidget(
                        roomData: roomCategoryModel.deluxe![0],
                        roomRemoveOnTap: () {
                          print("1");
                            context.read<SelectRoomCountCubit>().removeRoomEvent(
                                roomCategoryModel.deluxe![0].roomType!,
                                state.response.deluxValue);
                        },
                        roomAddOnTap: () {
                          print("2");
                            context.read<SelectRoomCountCubit>().addRoomEvent(
                                roomCategoryModel.deluxe![0].roomType!,
                                state.response.deluxValue,roomCategoryModel.deluxe!.length);

                        },
                        totalSelectedRoom: state.response.deluxValue,
                        isReadMore: state.response.deluxReadMore,
                        isRoomOnTap: () {
                          print("3");
                            context.read<SelectRoomCountCubit>().onReadMoreTap(
                                state.response.deluxReadMore,
                                roomCategoryModel.deluxe![0].roomType!);

                        },
                      )
                          : Center(),
                      roomCategoryModel.semiDeluxe!.isNotEmpty
                          ? RoomListWidget(
                        roomData: roomCategoryModel.semiDeluxe![0],
                        roomRemoveOnTap: () {
                          print(state.response);
                          context.read<SelectRoomCountCubit>().removeRoomEvent(
                              roomCategoryModel.semiDeluxe![0].roomType!,
                              state.response.semiDeluxValue);
                        },
                        roomAddOnTap: () {
                          context.read<SelectRoomCountCubit>().addRoomEvent(
                              roomCategoryModel.semiDeluxe![0].roomType!,
                              state.response.semiDeluxValue,roomCategoryModel.semiDeluxe!.length);
                        },
                        totalSelectedRoom: state.response.semiDeluxValue,
                        isReadMore: state.response.semiDeluxReadMore,
                        isRoomOnTap: () {
                          context.read<SelectRoomCountCubit>().onReadMoreTap(
                              state.response.semiDeluxReadMore,
                              roomCategoryModel.semiDeluxe![0].roomType!);
                        },
                      )
                          : Center(),
                      roomCategoryModel.superDeluxe!.isNotEmpty
                          ? RoomListWidget(
                        roomData: roomCategoryModel.superDeluxe![0],
                        roomRemoveOnTap: () {
                          context.read<SelectRoomCountCubit>().removeRoomEvent(
                              roomCategoryModel.superDeluxe![0].roomType!,
                              state.response.superDeluxValue);
                        },
                        roomAddOnTap: () {
                          context.read<SelectRoomCountCubit>().addRoomEvent(
                              roomCategoryModel.superDeluxe![0].roomType!,
                              state.response.superDeluxValue,roomCategoryModel.deluxe!.length);
                        },
                        totalSelectedRoom: state.response.superDeluxValue,
                        isReadMore: state.response.superDeluxReadMore,
                        isRoomOnTap: () {
                          context.read<SelectRoomCountCubit>().onReadMoreTap(
                              state.response.superDeluxReadMore,
                              roomCategoryModel.superDeluxe![0].roomType!);
                        },
                      )
                          : Center(),
                    ],
                  );
                }
                else{
                  return CircularProgressIndicator();
                }
              }
            ));
      } else {
        return const RoomCategoriesShimmerPage();
      }
    });
  }
}
