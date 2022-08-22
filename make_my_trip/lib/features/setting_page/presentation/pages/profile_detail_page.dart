import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/features/home_page/presentation/pages/homepage.dart';
import 'package:make_my_trip/features/setting_page/presentation/cubit/setting_page_cubit.dart';
import 'package:make_my_trip/features/setting_page/presentation/pages/settings_page.dart';
import 'package:make_my_trip/features/setting_page/presentation/widgets/common_appbar_widget.dart';
import 'package:make_my_trip/features/setting_page/presentation/widgets/shimmer_user_profile.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../home_page/home_page_injection_container.dart';
import '../../../home_page/presentation/cubit/homepage_cubit.dart';
import '../../../home_page/presentation/cubit/tab_bar_cubit.dart';
import '../widgets/settingProfile_body.dart';
import '../widgets/settingProfile_header.dart';

class ProfileDetailPage extends StatelessWidget {
  const ProfileDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MakeMyTripColors.colorWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MakeMyTripColors.colorWhite,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: (Platform.isAndroid)
                ? const Icon(
                    Icons.arrow_back_outlined,
                  )
                : const Icon(Icons.arrow_back_ios_new_rounded,
                    color: MakeMyTripColors.colorBlack)),
        title: const Text(StringConstants.userEditProfile,
            style: TextStyle(
                color: MakeMyTripColors.colorBlack,
                fontWeight: FontWeight.bold)),
      ),
      body: BlocBuilder<SettingPageCubit, BaseState>(builder: (context, state) {
        if (state is StateOnKnownToSuccess<SettingPageData>) {
          return state.response.profileLoading == false
              ? Container(
                  color: MakeMyTripColors.colorWhite,
                  child: SingleChildScrollView(
                    child: Column(children: [
                      settingProfileHeader(context),
                      settingProfileBody(context)
                    ]),
                  ))
              : const UserProfileShimmer();
        } else {
          return const Text(StringConstants.emptyString);
        }
      }),
    );
  }
}
