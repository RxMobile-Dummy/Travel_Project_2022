import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/features/admin_login/presentation/cubit/admin_login_cubit.dart';
import 'package:make_my_trip_admin_panel/features/admin_login/presentation/pages/admin_login_page.dart';
import 'package:make_my_trip_admin_panel/utils/constants/string_constants.dart';
import 'core/theme/make_my_trip_theme.dart';
import 'core/navigation/app_router.dart' as app_routes;
import 'firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: StringConstants.appTitle,
      theme: MakeMyTripLightTheme.lightTheme,
      home: BlocProvider<AdminLoginCubit>(
        create: (context) => AdminLoginCubit(),
        child: AdminLoginPage(),
      ),
    );
  }
}