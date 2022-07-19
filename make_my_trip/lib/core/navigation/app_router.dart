import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/features/hotel_listing/presentation/pages/splash_page.dart';
import 'package:make_my_trip/features/sign_up/domain/usecases/user_sign_up.dart';
import 'package:make_my_trip/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:make_my_trip/features/sign_up/presentation/pages/sign_up_page.dart';

import '../../features/sign_up/data/data_sources/sign_up_remote_datasource_impl.dart';
import '../../features/sign_up/data/repositories/sign_up_repository_impl.dart';
import '../../features/sign_up/domain/usecases/user_verification.dart';

///your app router here ::: use your route cubit

class Router {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (_) {
          return SplashPage();
        });
      case RoutesName.signup:
        return MaterialPageRoute(builder: (_) {
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
        });
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
