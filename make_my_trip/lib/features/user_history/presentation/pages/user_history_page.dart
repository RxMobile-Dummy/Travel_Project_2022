import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/user_history/data/model/user_history_model.dart';
import 'package:make_my_trip/features/user_history/presentation/cubit/user_history_cubit.dart';
import 'package:make_my_trip/features/user_history/presentation/pages/shimmer_history_page.dart';
import 'package:make_my_trip/features/user_history/presentation/widgets/history_list_view_widget.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/widgets/common_error_widget.dart';

import '../../data/model/user_history_model.dart';

class UserHistoryPage extends StatelessWidget {
  UserHistoryPage({Key? key}) : super(key: key);
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    context.read<UserHistoryCubit>.call()
        .setUpScrollController(_scrollController);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            StringConstants.bookingHeading,
            style: AppTextStyles.unselectedLabelStyle,
          ),
        ),
        body: SafeArea(child:
            BlocBuilder<UserHistoryCubit, BaseState>(builder: (context, state) {
          if (state is StateErrorGeneralStateErrorServer) {
            return CommonErrorWidget(
              onTap: () {
                BlocProvider.of<UserHistoryCubit>(context).getUserHistoryData();
              },
            );
          } else if (state is StateInternetError) {
            return CommonErrorWidget(
              title: "No Connection",
              subTitle: "Please check your internet connection and try again",
              onTap: () {
                BlocProvider.of<UserHistoryCubit>(context).getUserHistoryData();
              },
            );
          } else if (state is StateOnSuccess) {
            List<UserHistoryModel> userHistoryModel = state.response;
            if (userHistoryModel.isEmpty) {
              return const CommonErrorWidget(
                  imagePath: ImagePath.noBookingPage,
                  subTitle: "You don't have any booking at this moment",
                  title: "No bookings found");
            } else {
              return ListView.builder(
                  controller: _scrollController,
                  itemCount: state.isMoreLoading
                      ? userHistoryModel.length + 1
                      : userHistoryModel.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        if (index != userHistoryModel.length)
                          HistoryListViewWidget(
                            userHistoryModel: userHistoryModel[index],
                            reviewPostCall: (int hotelId) {
                              Navigator.pushNamed(
                                  context, RoutesName.publishReviewPage,
                                  arguments: {
                                    "hotel_id": hotelId,
                                    // 'rating': userHistoryModel.r
                                  });
                            },
                          ),
                        if (index == userHistoryModel.length)
                          const CircularProgressIndicator()
                      ],
                    );
                  });
            }
          } else {
            return const HistoryPageShimmer();
          }
        })));
  }
}
