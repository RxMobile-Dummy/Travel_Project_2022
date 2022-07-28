import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/internet/internet_cubit.dart';
import 'package:make_my_trip/features/home_page/presentation/cubit/homepage_cubit.dart';
import 'package:make_my_trip/features/home_page/presentation/widgets/imege_slidder_shimmer.dart';
import 'package:make_my_trip/features/home_page/presentation/widgets/slidable_image_list_widget.dart';
import 'package:make_my_trip/features/home_page/presentation/widgets/title_widget.dart';
import 'package:make_my_trip/features/home_page/presentation/widgets/top_view_widget.dart';
import 'package:make_my_trip/features/home_page/presentation/widgets/tour_list_widget.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:make_my_trip/utils/widgets/common_error_widget.dart';

import '../../../../utils/widgets/progress_loader.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomepageCubit, BaseState>(
      // buildWhen: (context, state) {
      //   print(state is InternetConnected);
      //   return state is InternetConnected;
      // },
      builder: (context, state) {
        if (state is StateErrorGeneral) {
          return CommonErrorWidget(
              imagePath: ImagePath.serverFailImage,
              title: StringConstants.serverFail,
              statusCode: "");
        }
        return Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  topView(context),
                  15.verticalSpace,
                  TitleWidget(
                      title: StringConstants.popularhotels,
                      viewAll: StringConstants.viewallTxt),
                  state is StateOnSuccess<GettingStartedData>
                      ? (state.response.imageLoading != true
                          ? slidableImageList()
                          : ImageSliderShimmer())
                      : Center(),
                  17.verticalSpace,
                  TitleWidget(
                      title: StringConstants.populartours,
                      viewAll: StringConstants.viewallTxt),
                  state is StateOnSuccess<GettingStartedData>
                      ? (state.response.tourLoading == true
                          ? ImageSliderShimmer()
                          : popularTourList())
                      : Center(),
                ],
              ),
            ),
          )),
        );
      },
    );
  }
}
