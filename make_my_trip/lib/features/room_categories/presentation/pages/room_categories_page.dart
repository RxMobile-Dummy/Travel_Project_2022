import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_categories_model.dart';
import 'package:make_my_trip/features/room_categories/presentation/cubit/room_category_cubit.dart';
import 'package:make_my_trip/features/room_categories/presentation/widgets/room_list_widget.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';

class RoomCategoriesPage extends StatelessWidget {
  RoomCategoriesPage({Key? key}) : super(key: key);

  RoomCategoryModel? roomCategoryModel;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomCategoryCubit, BaseState>(
      builder: (context, state) {
        if (state is StateOnKnownToSuccess) {
          roomCategoryModel = state.response;
        }
        return Scaffold(
            backgroundColor: MakeMyTripColors.color30gray,
            appBar: AppBar(
              backgroundColor: MakeMyTripColors.accentColor,
              leading: const Icon(Icons.arrow_back),
              title: Center(
                child: Column(
                  children: [
                    Text(
                      StringConstants.roomCategoriesPageHeading,
                      style: AppTextStyles.infoContentStyle3
                          .copyWith(fontSize: 15),
                    ),
                    Text(
                      roomCategoryModel?.hotelName ?? "Hotel Name",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.infoContentStyle3
                          .copyWith(fontSize: 18),
                    ),
                  ],
                ),
              ),
              actions: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(Icons.settings),
                ),
              ],
            ),
            body: (roomCategoryModel == null)
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: roomCategoryModel?.roomData!.length,
                    itemBuilder: (context, index) {
                      return RoomListWidget(
                          roomData: roomCategoryModel!.roomData![index]);
                    },
                  ));
      },
    );
  }
}
