import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/core/navigation/route_info.dart';
import 'package:make_my_trip_admin_panel/features/about_us/presentation/cubit/about_us_cubit.dart';
import 'package:make_my_trip_admin_panel/features/about_us/presentation/pages/about_us_page.dart';
import 'package:make_my_trip_admin_panel/features/faq/presentation/pages/faq_page.dart';
import 'package:make_my_trip_admin_panel/features/privacy_policy/presentation/cubit/privacy_policy_cubit.dart';
import 'package:make_my_trip_admin_panel/features/privacy_policy/presentation/pages/privacy_policy_page.dart';
import 'package:make_my_trip_admin_panel/features/terms_condition/presentation/cubit/terms_condition_cubit.dart';
import 'package:make_my_trip_admin_panel/features/terms_condition/presentation/pages/terms_condition_page.dart';
import '../../features/about_us/about_us_injection_container.dart';

import '../../features/contact_us/presentation/pages/contact_us_page.dart';
import '../../features/privacy_policy/privacy_policy_injection_container.dart';
import '../../features/terms_condition/terms_condition_injection_container.dart';

class Router {
  Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.faq:
        return MaterialPageRoute(builder: (_) {
          return FaqPage();
        });
      case RoutesName.contactUs:
        return MaterialPageRoute(builder: (_) {
          return ContactUsPage();
        });
      case RoutesName.aboutUs:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) =>
                slAboutUsPage<AboutUsCubit>()..getAboutUsData(),
            child: AboutUsPage(),
          );
        });
      case RoutesName.tc:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) =>
                slTcPage<TermsConditionCubit>()..getTermsConditionData(),
            child: TcPage(),
          );
        });
      case RoutesName.privacyPolicy:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) =>
                slPrivacyPage<PrivacyPolicyCubit>()..getPrivacyPolicyData(),
            child: PrivacyPolicyPage(),
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
