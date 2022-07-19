import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/features/hotel_listing/presentation/pages/home_page.dart';

import 'package:make_my_trip/features/hotel_listing/presentation/widgets/app_logo_widget.dart';
import 'package:make_my_trip/features/sign_up/data/data_sources/sign_up_remote_datasource_impl.dart';
import 'package:make_my_trip/features/sign_up/data/repositories/sign_up_repository_impl.dart';
import 'package:make_my_trip/features/sign_up/domain/usecases/user_verification.dart';
import 'package:make_my_trip/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:make_my_trip/features/sign_up/presentation/pages/sign_up_page.dart';

import 'package:make_my_trip/features/home_page/presentation/manager/cubit/tab_bar_cubit.dart';
import 'package:make_my_trip/features/hotel_listing/presentation/widgets/app_logo_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../sign_up/domain/usecases/user_sign_up.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    Timer(const Duration(seconds: 2), () async {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.getString('email') != null) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          return BlocProvider(
            create: (context) => SignUpCubit(
                userVerification: UserVerification(
                    repository: SignUpRepositoryImpl(
                        remoteDataSource: SignUpRemoteDataSourceImpl(
                            auth: FirebaseAuth.instance))),
                userSignUp: UserSignUp(
                    repository: SignUpRepositoryImpl(
                        remoteDataSource: SignUpRemoteDataSourceImpl(
                            auth: FirebaseAuth.instance)))),
            child: SignUpPage(),
          );
        }), (route) => false);
      }
    });
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
