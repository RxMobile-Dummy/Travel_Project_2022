import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/features/home_page/presentation/manager/cubit/tab_bar_cubit.dart';
import 'package:make_my_trip/features/hotel_listing/presentation/widgets/app_logo_widget.dart';

import '../../../home_page/presentation/pages/homepage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    Timer(const Duration(seconds: 2), () async {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return BlocProvider(
          create: (context) => TabBarCubit(),
          child: HomePage(),
        );
      }), (route) => false);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        body: AppLogoWidget(),
      ),
    );
  }
}
