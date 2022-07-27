import 'package:flutter/material.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/features/setting_page/presentation/widgets/common_appbar_widget.dart';
import 'package:make_my_trip/features/setting_page/presentation/widgets/setting_list_widget.dart';
import 'package:make_my_trip/features/setting_page/presentation/widgets/user_profile_widget.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
        backgroundColor: MakeMyTripColors.colorWhite,
        appBar: commonAppBarWidget(
            text: StringConstants.setting,
            context: context,
            routename: RoutesName.home),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              userProfileWidget(context),
              settingListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
