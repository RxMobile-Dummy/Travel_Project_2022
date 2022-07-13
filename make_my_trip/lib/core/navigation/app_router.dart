import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/features/hotel_listing/presentation/pages/splash_page.dart';
import 'package:make_my_trip/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:make_my_trip/features/sign_up/presentation/pages/SignUpOneView.dart';

import '../../features/sign_up/data/data_sources/register_user_repository_impl.dart';
import '../../features/sign_up/data/repositories/register_user_repository_impl.dart';
import '../../features/sign_up/domain/use_cases/register_user_usecase.dart';

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
            create: (context) => SignUpCubit(registerusecase: Register_User_Usecase(register_user_repository: Register_User_Repository_Impl(register_user_datasource: Register_User_Datasource_Impl()))),
            child: SignUpOneView(),
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
