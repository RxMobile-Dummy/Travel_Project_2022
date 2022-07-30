import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:make_my_trip/features/splash/presentation/widgets/app_logo_widget.dart';
import 'package:make_my_trip/features/splash/splash_injection_container.dart';
import 'package:make_my_trip/features/user/presentation/cubit/user_cubit.dart';
import '../widgets/app_logo_widget.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, BaseState>(
      bloc: splashSl<SplashCubit>()..splashLoad(),
      listener: (context, state) {
        if (state is Unauthenticated) {
          Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.onBoard, (route) => false);
        } else if (state is Authenticated) {
          Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.home, (route) => false);
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
