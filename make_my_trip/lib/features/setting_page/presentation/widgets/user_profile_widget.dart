import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/setting_page/presentation/cubit/setting_page_cubit.dart';
import 'package:make_my_trip/features/setting_page/presentation/pages/profile_detail_page.dart';
import 'package:make_my_trip/features/setting_page/setting_page_injection_container.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';

Widget userProfileWidget(BuildContext context) {
  return Column(
    children: [
      BlocBuilder<SettingPageCubit, BaseState>(builder: (context, state) {
        if (state is StateOnKnownToSuccess<SettingPageData>) {
          return CircleAvatar(
            backgroundImage: NetworkImage(state.response.userValue?.userImage ??
                StringConstants.emptyString),
            radius: 50,
            backgroundColor: MakeMyTripColors.colorLightGray,
          );
        } else {
          return CircleAvatar(
            backgroundImage: AssetImage(ImagePath.userProfileImage1),
            radius: 50,
            backgroundColor: MakeMyTripColors.colorLightGray,
          );
        }
      }),
      BlocBuilder<SettingPageCubit, BaseState>(builder: (context, state) {
        if (state is StateOnKnownToSuccess<SettingPageData>) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
            child: Text(
              state.response.userValue?.userName ?? StringConstants.userName,
              style: AppTextStyles.unselectedLabelStyle,
            ),
          );
        } else {
          return const Padding(
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
            child: Text(
              StringConstants.userName,
              style: AppTextStyles.unselectedLabelStyle,
            ),
          );
        }
      }),
      BlocBuilder<SettingPageCubit, BaseState>(builder: (context, state) {
        if (state is StateOnKnownToSuccess<SettingPageData>) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
            child: Text(
              state.response.userValue?.userEmail ??
                  StringConstants.emptyString,
              style: AppTextStyles.infoContentStyle
                  .copyWith(fontWeight: FontWeight.w500),
            ),
          );
        } else {
          return const Padding(
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
            child: Text(
              StringConstants.emptyString,
              style: AppTextStyles.unselectedLabelStyle,
            ),
          );
        }
      }),
      Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider<SettingPageCubit>(
                          create: (BuildContext context) =>
                              slSettingPage<SettingPageCubit>(),
                          child: const ProfileDetailPage(),
                        )));
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
                padding:
                    const EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 5),
                height: 30,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  border: Border.all(color: MakeMyTripColors.color50gray),
                ),
                child:
                    const Center(child: Text(StringConstants.userEditProfile))),
          ),
        ),
      ),
      const Divider(
        height: 20,
        thickness: 1,
        indent: 0,
        endIndent: 0,
        color: MakeMyTripColors.color30gray,
      ),
    ],
  );
}
