import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/injection_container.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/presentation/cubit/hotel_cubit.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/presentation/pages/add_hotels.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/presentation/pages/get_hotels_ui.dart';
import 'package:make_my_trip_admin_panel/utils/constants/string_constants.dart';
import 'core/theme/make_my_trip_theme.dart';
import 'firebase_options.dart';
import 'dart:io';
import './features/add_hotels/injection_container.dart';
import './features/add_hotels/injection_container.dart' as di;
Future<void> main() async {
  await di.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HotelCubit>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: StringConstants.appTitle,
        theme: MakeMyTripLightTheme.lightTheme,
        home: GetHotelUi(),
      ),
    );
  }
}
