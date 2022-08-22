import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:make_my_trip/features/splash/presentation/widgets/app_logo_widget.dart';
import 'package:make_my_trip/features/splash/splash_injection_container.dart';
import 'package:make_my_trip/features/user/presentation/cubit/user_cubit.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/widgets/common_error_widget.dart';
import '../../../../core/theme/make_my_trip_colors.dart';
import '../widgets/app_logo_widget.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashCubit, BaseState>(
      bloc: splashSl<SplashCubit>()..splashLoad(),
      listener: (context, state) {
        if (state is StateOnSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.onBoard, (route) => false,
              arguments: {"hotel_id": state.response});
        } else if (state is StateOnResponseSuccess && state.response == null) {
          Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.home, (route) => false);
        } else if (state is StateOnResponseSuccess && state.response != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.hotelDetail, (route) => false, arguments: {
            "hotel_id": int.parse(state.response),
            "share_link": true
          });
        }
      },
      builder: (context, state) {
        if (state is StateErrorGeneralStateErrorServer) {
          return CommonErrorWidget(
              imagePath: ImagePath.serverFailImage,
              title: "Somthing went wrong",
              statusCode: "");
        }
        return const Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: MakeMyTripColors.colorWhite,
          body: AppLogoWidget(),
        );
      },
    );
  }
}
