import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/features/setting_page/presentation/cubit/setting_page_cubit.dart';
import '../../../../utils/constants/string_constants.dart';
import '../widgets/settingProfile_body.dart';
import '../widgets/settingProfile_header.dart';

class ProfileDetailPage extends StatelessWidget {
  const ProfileDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
        backgroundColor: MakeMyTripColors.colorWhite,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: MakeMyTripColors.colorWhite,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios,
                  color: MakeMyTripColors.colorBlack)),
          title: const Text(StringConstants.userEditProfile,
              style: TextStyle(
                  color: MakeMyTripColors.colorBlack,
                  fontWeight: FontWeight.bold)),
        ),
        body: Container(
            color: MakeMyTripColors.colorWhite,
            child: ListView(children: [
              SettingProfileHeader(context),
              SettingProfileBody(context)
            ])),
      ),
    );
  }
}
