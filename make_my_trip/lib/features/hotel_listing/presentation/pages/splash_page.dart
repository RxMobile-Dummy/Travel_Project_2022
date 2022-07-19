import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/features/settings/presentation/pages/settings_page.dart';
import '../../../splash/presentation/widgets/app_logo_widget.dart';

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
      Navigator.pushNamed(context, RoutesName.login);
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
