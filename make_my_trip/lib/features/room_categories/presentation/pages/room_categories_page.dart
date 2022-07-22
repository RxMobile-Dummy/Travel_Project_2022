import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_categories_model.dart';
import 'package:make_my_trip/features/room_categories/presentation/cubit/room_category_cubit.dart';
import 'package:make_my_trip/features/room_categories/presentation/pages/room_categories_shimmer_page.dart';
import 'package:make_my_trip/features/room_categories/presentation/widgets/room_list_widget.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';

class RoomCategoriesPage extends StatelessWidget {
  const RoomCategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomCategoryCubit, BaseState>(builder: (context, state) {
      if (state is StateOnKnownToSuccess) {
        RoomCategoryModel roomCategoryModel = state.response;

        return Scaffold(
          backgroundColor: MakeMyTripColors.color30gray,
          appBar: AppBar(
            leading: const Icon(Icons.arrow_back),
            title: Center(
              child: Column(
                children: [
                  Text(
                    StringConstants.roomCategoriesPageHeading,
                    style:
                        AppTextStyles.infoContentStyle3.copyWith(fontSize: 15),
                  ),
                  Text(
                    roomCategoryModel.hotelName!,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style:
                        AppTextStyles.infoContentStyle3.copyWith(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          body: ListView(
            children: [
              RoomListWidget(
                  roomData: roomCategoryModel.deluxe!,
                  roomRemoveOnTap: () {
                    // context.read<RoomCategoryCubit>().removeRoomEvent(
                    //     roomCategoryModel.deluxe![0].roomType!,
                    //     state.response.deluxValue);
                  },
                  roomAddOnTap: () {
                    // context.read<RoomCategoryCubit>().addRoomEvent(
                    //     roomCategoryModel.deluxe![0].roomType!,
                    //     state.response.deluxValue);
                  },
                 totalSelectedRoom: 1),
              // RoomListWidget(
              //     roomData: roomCategoryModel.semiDeluxe!,
              //     roomRemoveOnTap: () {
              //       context.read<RoomCategoryCubit>().removeRoomEvent(
              //           roomCategoryModel.semiDeluxe![0].roomType!,
              //           state.response.semiDeluxValue);
              //     },
              //     roomAddOnTap: () {
              //       context.read<RoomCategoryCubit>().addRoomEvent(
              //           roomCategoryModel.semiDeluxe![0].roomType!,
              //           state.response.semiDeluxValue);
              //     },
              //     totalSelectedRoom: state.response.semiDeluxValue),
              // RoomListWidget(
              //     roomData: roomCategoryModel.superDeluxe!,
              //     roomRemoveOnTap: () {
              //       context.read<RoomCategoryCubit>().removeRoomEvent(
              //           roomCategoryModel.superDeluxe![0].roomType!,
              //           state.response.superDeluxValue);
              //     },
              //     roomAddOnTap: () {
              //       context.read<RoomCategoryCubit>().addRoomEvent(
              //           roomCategoryModel.superDeluxe![0].roomType!,
              //           state.response.superDeluxValue);
              //     },
              //     totalSelectedRoom: state.response.superDeluxValue),
            ],
          ),
        );
      } else {
        return const RoomCategoriesShimmerPage();
      }
    });
  }
}
