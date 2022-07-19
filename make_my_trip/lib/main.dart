import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/make_my_trip_theme.dart';
import './core/navigation/app_router.dart' as AppRoutes;
import 'firebase_options.dart';
import 'injection_container.dart' as di;
import 'features/hotel_detail/hotel_detail_injection_container.dart'
    as diHotelDeatail;

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await diHotelDeatail.init();
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
      title: 'Make My Trip',
      theme: MakeMyTripLightTheme.lightTheme,
      onGenerateRoute: AppRoutes.Router.generateRoutes,
    );
  }
}
