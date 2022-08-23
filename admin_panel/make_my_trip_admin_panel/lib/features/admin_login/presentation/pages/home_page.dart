import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/core/base/base_state.dart';
import 'package:make_my_trip_admin_panel/core/navigation/route_info.dart';
import 'package:make_my_trip_admin_panel/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip_admin_panel/core/theme/text_styles.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/admin_booking_moderation_injection_container.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/presentation/cubit/admin_booking_moderation_cubit.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/presentation/pages/admin_booking_page.dart';
import 'package:make_my_trip_admin_panel/features/admin_login/presentation/cubit/admin_login_cubit.dart';
import 'package:make_my_trip_admin_panel/utils/constants/image_path.dart';
import 'package:make_my_trip_admin_panel/utils/constants/string_constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminLoginCubit, BaseState>(
      listener: (context, state) {
        if (state is StateOnSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.adminLogin, (route) => false);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Drawer(
                    backgroundColor: MakeMyTripColors.customLightBlue,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        DrawerHeader(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Image.asset(
                                  ImagePath.logoImg,
                                ),
                              ),
                              Text(
                                StringConstants.adminPanelLabel,
                                style: AppTextStyles.labelStyle2.copyWith(
                                    color: MakeMyTripColors.color70gray),
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          autofocus: true,
                          focusColor: MakeMyTripColors.colorCwsPrimary,
                          title: Text(
                            StringConstants.bookingModerationLabel,
                            style: AppTextStyles.infoContentStyle,
                          ),
                          onTap: () {
                            context.read<AdminLoginCubit>().changeViewEvent(
                                StringConstants.bookingModerationLabel);
                          },
                        ),
                        ListTile(
                          autofocus: true,
                          title: Text(
                            StringConstants.logOutLabel,
                            style: AppTextStyles.infoContentStyle,
                          ),
                          onTap: () {
                            context.read<AdminLoginCubit>().logOutEvent();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: state is StateOnResponseSuccess &&
                          state.response ==
                              StringConstants.bookingModerationLabel
                      ? BlocProvider<AdminBookingModerationCubit>(
                          create: (context) =>
                              slBookingModeration<AdminBookingModerationCubit>()
                                ..getAllBookingListEvent(
                                    checkInDateValue: DateTime.now()
                                        .toString()
                                        .substring(0, 10)),
                          child: (AdminBookingPage()),
                        )
                      : const SizedBox(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
