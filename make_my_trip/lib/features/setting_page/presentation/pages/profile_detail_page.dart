import 'package:flutter/material.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/features/setting_page/presentation/widgets/common_appbar_widget.dart';

import '../../../../utils/constants/string_constants.dart';
import '../widgets/settingProfile_body.dart';
import '../widgets/settingProfile_header.dart';

class ProfileDetailPage extends StatelessWidget {
  const ProfileDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return _moveToScreen2(context);
      },
      child: Scaffold(
        backgroundColor: MakeMyTripColors.colorWhite,
        appBar: commonAppBarWidget(
            text: StringConstants.userEditProfile,
            context: context,
            routename: RoutesName.settingPage),
        body: Column(children: [
          settingProfileHeader(context),
          settingProfileBody(context)
        ]),
      ),
    );
  }
}

_moveToScreen2(BuildContext context) {
  return Navigator.pushNamedAndRemoveUntil(
      context, RoutesName.settingPage, (route) => false);
}
