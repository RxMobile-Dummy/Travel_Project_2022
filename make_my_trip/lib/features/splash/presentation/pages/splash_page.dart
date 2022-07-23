import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:make_my_trip/features/splash/presentation/widgets/app_logo_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/app_logo_widget.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, BaseState>(
      bloc: SplashCubit()..splashLoad(),
      listener: (context, state) async {
        if (state is StateNoData) {
          final sh = await SharedPreferences.getInstance();
          if (sh.getString("userId") == null) {
            Navigator.pushNamedAndRemoveUntil(
                context, RoutesName.onBoard, (route) => false);
          } else {
            Navigator.pushNamedAndRemoveUntil(
                context, RoutesName.home, (route) => false);
          }
        }
      },
      child: const Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        body: AppLogoWidget(),
      ),
    );
  }
}
