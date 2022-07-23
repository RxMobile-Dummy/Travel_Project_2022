import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/setting_page/data/models/user_details_model.dart';
import 'package:make_my_trip/features/setting_page/presentation/cubit/setting_page_cubit.dart';
import 'package:make_my_trip/features/setting_page/presentation/pages/profile_detail_page.dart';
import 'package:make_my_trip/features/setting_page/setting_page_injection_container.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';

Widget userProfileWidget(BuildContext context) {
  context.read<SettingPageCubit>().getUserData();
  print("cubit call");
  return BlocBuilder<SettingPageCubit, BaseState>(
    builder: (context, state) {
      if (state is StateOnKnownToSuccess) {
        UserDetailsModel userModel = state.response;
        return Column(
          children: [
            BlocBuilder<SettingPageCubit, BaseState>(
              builder: (context, state) {
                return CircleAvatar(
                  backgroundImage: NetworkImage(userModel.userImage.toString()),
                  radius: 50,
                );
              },
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
              child: Text(
                userModel.userName.toString(),
                style: AppTextStyles.unselectedLabelStyle,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
              child: Text(
                userModel.userEmail.toString(),
                style: TextStyle(
                    color: MakeMyTripColors.colorBlack,
                    fontWeight: FontWeight.w500),
              ),
            ),
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
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5, right: 5, left: 5),
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: MakeMyTripColors.color50gray),
                      ),
                      child: const Center(
                          child: Text(StringConstants.userEditProfile))),
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
      } else {
        return CircularProgressIndicator();
      }
    },
  );
}
