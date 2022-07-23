import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:make_my_trip/features/splash/presentation/widgets/app_logo_widget.dart';
import 'package:make_my_trip/features/user/presentation/cubit/user_cubit.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/app_logo_widget.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, BaseState>(
      listener: (context, state) {
        print(state.toString());
        if (state is Unauthenticated) {
          Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.onBoard, (route) => false);
        } else if (state is Authenticated) {
          Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.home, (route) => false);
        }
      },
      child: BlocListener<SplashCubit, BaseState>(
        bloc: SplashCubit()..splashLoad(),
        listener: (context, state) async {
          if (state is StateNoData) {
            BlocProvider.of<UserCubit>(context).checkIsAnonymousUser();
          }
        },
        child: const Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.white,
          body: AppLogoWidget(),
        ),
      ),
    );
  }
}
