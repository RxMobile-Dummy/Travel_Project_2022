import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/room_categories/presentation/widgets/room_list_widget.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';

class RoomCategoriesPage extends StatelessWidget {
  const RoomCategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MakeMyTripColors.accentColor,
          leading: const Icon(Icons.arrow_back),
          title: Center(
            child: Column(
              children: [
                Text(
                  StringConstants.roomCategoriesPageHeading,
                  style: AppTextStyles.infoContentStyle3.copyWith(fontSize: 20),
                ),
                Text(
                  StringConstants.hotelName,
                  style: AppTextStyles.infoContentStyle3,
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
        body: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) {
            return const RoomListWidget();
          },
        ));
  }
}
