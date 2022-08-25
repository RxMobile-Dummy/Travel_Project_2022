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
        appBar: AppBar(
          title: Text(
            StringConstants.bookingHeading,
            style: AppTextStyles.unselectedLabelStyle,
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<UserHistoryCubit, BaseState>(
            builder: (context, state) {
              if (state is StateErrorGeneralStateErrorServer) {
                return CommonErrorWidget(
                  onTap: () {
                    BlocProvider.of<UserHistoryCubit>(context)
                        .getUserHistoryData();
                  },
                );
              }else  if(state is StateInternetError){
                return CommonErrorWidget(title: "No Connection",subTitle: "Please check your internet connection and try again",
                  onTap: () {
                    BlocProvider.of<UserHistoryCubit>(context)
                        .getUserHistoryData();
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
                      itemCount: userHistoryModel.length,
                      itemBuilder: (context, index) {
                        return HistoryListViewWidget(
                            userHistoryModel: userHistoryModel[index]);
                      });
                }
              } else {
                return const HistoryPageShimmer();
              }
            },
          ),
        ));
  }
}
