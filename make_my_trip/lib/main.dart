import 'dart:io';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/theme/make_my_trip_theme.dart';
import 'package:make_my_trip/features/setting_page/setting_page_injection_container.dart'
    as setting_page_di;
import 'package:make_my_trip/features/user/user_injection_container.dart';
import 'package:make_my_trip/features/user/presentation/cubit/user_cubit.dart';
import './core/navigation/app_router.dart' as app_routes;
import 'core/internet/internet_cubit.dart';
import 'core/internet/internet_injection_container.dart';
import 'firebase_options.dart';
import './features/home_page/home_page_injection_container.dart'
    as home_page_di;
import './features/hotel_detail/hotel_detail_injection_container.dart'
    as hotel_detail_di;
import './features/review/review_injection_container.dart' as review_di;
import './features/room_categories/room_categories_injection_container.dart'
    as room_category_di;
import './features/room_detail_page/room_detail_injection_container.dart'
    as room_detail_di;
import './features/hotel_listing/hotel_list_injection_container.dart'
    as hotel_list_di;
import 'features/intro/intro_injection_container.dart' as intro_di;
import './features/wishlist/wishlist_injection_container.dart' as wishlist_di;
import 'features/user/user_injection_container.dart' as user_di;
import 'features/splash/splash_injection_container.dart' as splash_di;
import './features/search/search_hotel_injection_container.dart' as search_di;
import 'features/user_history/user_history_injection_container.dart'
    as history_di;
import 'features/booking/booking_injection_container.dart' as booking_di;
import 'core/internet/internet_injection_container.dart' as internet_di;
import 'package:amplify_flutter/amplify_flutter.dart';
import 'amplifyconfiguration.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await internet_di.init();
  await intro_di.init();
  await user_di.init();
  await splash_di.init();
  await home_page_di.init();
  await hotel_detail_di.init();
  await review_di.init();
  await room_category_di.init();
  await room_detail_di.init();
  await hotel_list_di.init();
  await wishlist_di.init();
  await history_di.init();
  await search_di.init();
  await setting_page_di.init();

  await booking_di.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    super.initState();
    _configureAmplify();
    // recordCustomEvent();
  }

  Future<void> _configureAmplify() async {
    // You can use addPlugins if you are going to be adding multiple plugins
    final analyticsPlugin = AmplifyAnalyticsPinpoint();
    final authPlugin = AmplifyAuthCognito();
    await Amplify.addPlugins([authPlugin, analyticsPlugin]);
    try {
      await Amplify.configure(amplifyconfig);
      print("setup done");
    } on AmplifyAlreadyConfiguredException {
      print(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    } catch (e) {
      print("Exception:");
      print(e);
    }
  }

  // Future<void> recordCustomEvent() async {
  //   final event = AnalyticsEvent('addtocart');

  //   AnalyticsUserProfile analyticsUserProfile = new AnalyticsUserProfile();
  //               final AnalyticsProperties analyticsProperties = AnalyticsProperties();
  //               analyticsProperties.addDoubleProperty('wallet', 100);
  //               analyticsProperties.addStringProperty('login', 'google');
  //               analyticsUserProfile.properties = analyticsProperties;
  //               analyticsUserProfile.email = username;
  //               await Amplify.Analytics.identifyUser(userId: awsId, userProfile: analyticsUserProfile);
  //               await Amplify.Analytics.flushEvents();

  //   event.properties
  //     ..addStringProperty('Channel', 'SMS')
  //     ..addBoolProperty('Successful', true);

  //   // You can also add the properties one by one like the following
  //   event.properties.addIntProperty('ProcessDuration', 792);
  //   event.properties.addDoubleProperty('doubleKey', 120.3);
  //   print("event recorded");
  //   await Amplify.Analytics.recordEvent(event: event);
  // }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => userSl<UserCubit>(),
        ),
        BlocProvider(
          create: (context) => internetSl<InternetCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Make My Trip',
        theme: MakeMyTripLightTheme.lightTheme,
        onGenerateRoute: app_routes.Router().generateRoutes,
      ),
    );
  }
}
