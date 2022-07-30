import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/setting_page/presentation/cubit/setting_page_cubit.dart';
import 'package:make_my_trip/features/setting_page/presentation/widgets/common_appbar_widget.dart';
import 'package:make_my_trip/features/setting_page/presentation/widgets/setting_list_widget.dart';
import 'package:make_my_trip/features/setting_page/presentation/widgets/user_profile_widget.dart';
import 'package:make_my_trip/features/user/presentation/cubit/user_cubit.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, BaseState>(
      listener: (context, state) {
        if(state is StateOnSuccess)
          {
            Navigator.pushNamedAndRemoveUntil(context, RoutesName.home, (route) => false);
          }
      },
      child: SafeArea(
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 12.0),
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: settingList.length,
                      itemBuilder: (context, index) =>
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, settingList[index].routeName);
                              },
                              child: SizedBox(
                                child: Row(
                                  children: [
                                    Icon(settingList[index].icon),
                                    10.horizontalSpace,
                                    Text(settingList[index].text,
                                        style: AppTextStyles.infoLabelStyle
                                            .copyWith(fontSize: 16)),
                                    const Spacer(),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      color: MakeMyTripColors.color30gray,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: GestureDetector(
                    onTap: () {
                      context.read<UserCubit>().userSignOutEvent();
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.logout),
                        10.horizontalSpace,
                        Text(StringConstants.logout,
                            style: AppTextStyles.infoLabelStyle
                                .copyWith(fontSize: 16)),
                        const Spacer(),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: MakeMyTripColors.color30gray,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
