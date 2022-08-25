import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/core/base/base_state.dart';
import 'package:make_my_trip_admin_panel/core/navigation/route_info.dart';
import 'package:make_my_trip_admin_panel/features/splash/presentation/cubit/splash_screen_cubit.dart';
import 'package:make_my_trip_admin_panel/utils/constants/image_path.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, BaseState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.pushReplacementNamed(context, RoutesName.homePage);
        } else if (state is Unauthenticated) {
          Navigator.pushReplacementNamed(context, RoutesName.adminLogin);
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        body: Center(
            child: Image.asset(
          ImagePath.logoImg,
        )),
      ),
    );
  }
}
