import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/user_history/data/model/user_history_model.dart';
import 'package:make_my_trip/features/user_history/presentation/cubit/user_history_cubit.dart';
import 'package:make_my_trip/features/user_history/presentation/pages/shimmer_history_page.dart';
import 'package:make_my_trip/features/user_history/presentation/widgets/history_list_view_widget.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/widgets/common_error_widget.dart';

class UserHistoryPage extends StatelessWidget {
  const UserHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.arrow_back_ios),
                Text(
                  StringConstants.bookingHeading,
                  style: AppTextStyles.unselectedLabelStyle,
                ),
                const Icon(Icons.notifications_outlined),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<UserHistoryCubit, BaseState>(
              builder: (context, state) {
                if (state is StateOnSuccess) {
                  List<UserHistoryModel> userHistoryModel = state.response;
                  if (userHistoryModel.isEmpty) {
                    return CommonErrorWidget(
                        imagePath: ImagePath.noBookingPage,
                        title: StringConstants.noBooking,
                        statusCode: "");
                  }
                  return ListView.builder(
                      itemCount: userHistoryModel.length,
                      itemBuilder: (context, index) {
                        return HistoryListViewWidget(
                            userHistoryModel: userHistoryModel[index]);
                      });
                } else if (state is StateErrorGeneral) {
                  return CommonErrorWidget(
                      imagePath: ImagePath.serverFailImage,
                      title: StringConstants.serverFail,
                      statusCode: "505");
                } else if (state is StateLoading) {
                  return const HistoryPageShimmer();
                } else {
                  return const Center(child: Text("No data found"));
                }
              },
            ),
          )
        ],
      ),
    ));
  }
}
