import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/features/setting_page/presentation/widgets/appbar_widget.dart';
import 'package:make_my_trip/features/setting_page/presentation/widgets/setting_list_widget.dart';
import 'package:make_my_trip/features/setting_page/presentation/widgets/user-profile_widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
        backgroundColor: MakeMyTripColors.colorWhite,
        appBar: settingPageAppBarWidget(),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
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
