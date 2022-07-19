import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:make_my_trip/features/splash/presentation/widgets/app_logo_widget.dart';
import '../../../../core/navigation/route_info.dart';
import '../../../settings/presentation/pages/settings_page.dart';
import '../widgets/app_logo_widget.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, BaseState>(
      bloc: SplashCubit()..splashLoad(),
      listener: (context, state) {
        if (state is StateNoData) {
          // Navigator.pushNamedAndRemoveUntil(
          //     context, RoutesName.onBoard, (route) => false);
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => SettingsPage()));
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
