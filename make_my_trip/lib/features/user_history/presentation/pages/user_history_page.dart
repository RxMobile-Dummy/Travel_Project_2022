import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
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
    context.read<UserHistoryCubit>.call().setUpScrollController(_scrollController);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            StringConstants.bookingHeading,
            style: AppTextStyles.unselectedLabelStyle,
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<UserHistoryCubit, BaseState>(
            builder: (context, state) {
              if (state is StateOnSuccess) {
                List<UserHistoryModel> userHistoryModel =
                    state.response as List<UserHistoryModel>;
                if (userHistoryModel.isEmpty) {
                  return CommonErrorWidget(
                      imagePath: ImagePath.noBookingPage,
                      title: StringConstants.noBooking,
                      statusCode: "");
                }
                return ListView.builder(
                  controller: _scrollController,
                    itemCount: state.isMoreLoading?userHistoryModel.length+1 : userHistoryModel.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          if(index!=userHistoryModel.length)
                          HistoryListViewWidget(
                              userHistoryModel: userHistoryModel[index]),
                          if(index==userHistoryModel.length)
                            const CircularProgressIndicator()

                        ],
                      );
                    });
              } else if (state is StateErrorGeneral) {
                return CommonErrorWidget(
                    imagePath: ImagePath.serverFailImage,
                    title: StringConstants.serverFail,
                    statusCode: "");
              } else if (state is StateLoading) {
                return const HistoryPageShimmer();
              } else {
                return const Center(child: Text(StringConstants.noDatatxt));
              }
            },
          ),
        ));
  }
}

