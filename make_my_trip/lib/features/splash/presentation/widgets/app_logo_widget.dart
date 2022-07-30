import 'package:flutter/cupertino.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Image.asset(
      ImagePath.appLogoGif,
    ));
  }
}
