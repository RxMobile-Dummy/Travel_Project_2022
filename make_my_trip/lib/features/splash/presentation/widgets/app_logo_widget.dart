import 'package:flutter/cupertino.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Image.asset(
      "assets/icons/ic_app_logo.png",
    ));
  }
}
