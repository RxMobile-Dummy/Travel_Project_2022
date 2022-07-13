import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:make_my_trip/features/hotel_listing/presentation/widgets/app_logo_widget.dart';
import 'package:make_my_trip/features/sign_up/data/data_sources/User_form_datasources_impl.dart';
import 'package:make_my_trip/features/sign_up/data/repositories/User_repository_impl.dart';
import 'package:make_my_trip/features/sign_up/domain/use_cases/register_usecase.dart';
import 'package:make_my_trip/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:make_my_trip/features/sign_up/presentation/pages/SignUpOneView.dart';


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
              create: (context) => SignUpCubit(registerusecase: Registerusecase(register_repository: Userrepository_impl(userformdatasources: Userformdatasourcesimpl()))),
              child: SignUpOneView(),
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