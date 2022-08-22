import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/core/base/base_state.dart';
import 'package:make_my_trip_admin_panel/core/navigation/route_info.dart';
import 'package:make_my_trip_admin_panel/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip_admin_panel/core/theme/text_styles.dart';
import 'package:make_my_trip_admin_panel/features/about_us/presentation/cubit/about_us_cubit.dart';
import 'package:make_my_trip_admin_panel/features/about_us/presentation/pages/about_us_page.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/admin_booking_moderation_injection_container.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/presentation/cubit/admin_booking_moderation_cubit.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/presentation/pages/admin_booking_page.dart';
import 'package:make_my_trip_admin_panel/features/admin_login/presentation/cubit/admin_login_cubit.dart';
import 'package:make_my_trip_admin_panel/features/faq/presentation/cubit/faq_cubit.dart';
import 'package:make_my_trip_admin_panel/features/faq/presentation/pages/faq_page.dart';
import 'package:make_my_trip_admin_panel/features/privacy_policy/presentation/cubit/privacy_policy_cubit.dart';
import 'package:make_my_trip_admin_panel/features/privacy_policy/presentation/pages/privacy_policy_page.dart';
import 'package:make_my_trip_admin_panel/features/review_moderation/presentation/cubit/review_moderation_cubit.dart';
import 'package:make_my_trip_admin_panel/features/review_moderation/presentation/pages/review_moderation.dart';
import 'package:make_my_trip_admin_panel/features/terms_condition/presentation/cubit/terms_condition_cubit.dart';
import 'package:make_my_trip_admin_panel/features/terms_condition/presentation/pages/terms_condition_page.dart';
import 'package:make_my_trip_admin_panel/utils/constants/image_path.dart';
import 'package:make_my_trip_admin_panel/utils/constants/string_constants.dart';

import '../../../review_moderation/review_moderation_injection_container.dart';
import '../../../about_us/about_us_injection_container.dart';
import '../../../faq/faq_injection_container.dart';
import '../../../terms_condition/terms_condition_injection_container.dart';
import '../../../privacy_policy/privacy_policy_injection_container.dart';

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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                    color: MakeMyTripColors.customDarkBlue),
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          autofocus: true,
                          leading: const Icon(Icons.calendar_month_sharp),
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
                          leading: const Icon(Icons.edit_note_rounded),
                          title: const Text(
                            StringConstants.reviewAppbarTitle,
                            style: AppTextStyles.infoContentStyle,
                          ),
                          onTap: () {
                            context.read<AdminLoginCubit>().changeViewEvent(
                                StringConstants.reviewAppbarTitle);
                          },
                        ),
                        ListTile(
                          autofocus: true,
                          leading: const Icon(Icons.message),
                          title: Text(
                            StringConstants.faq,
                            style: AppTextStyles.infoContentStyle,
                          ),
                          onTap: () {
                            context
                                .read<AdminLoginCubit>()
                                .changeViewEvent(StringConstants.faq);
                          },
                        ),
                        ListTile(
                          autofocus: true,
                          leading: const Icon(Icons.info_rounded),
                          title: Text(
                            StringConstants.aboutUs,
                            style: AppTextStyles.infoContentStyle,
                          ),
                          onTap: () {
                            context
                                .read<AdminLoginCubit>()
                                .changeViewEvent(StringConstants.aboutUs);
                          },
                        ),
                        ListTile(
                          autofocus: true,
                          leading: const Icon(Icons.note_alt_rounded),
                          title: Text(
                            StringConstants.tc,
                            style: AppTextStyles.infoContentStyle,
                          ),
                          onTap: () {
                            context
                                .read<AdminLoginCubit>()
                                .changeViewEvent(StringConstants.tc);
                          },
                        ),
                        ListTile(
                          autofocus: true,
                          leading: const Icon(Icons.shield_rounded),
                          title: Text(
                            StringConstants.privacyPolicy,
                            style: AppTextStyles.infoContentStyle,
                          ),
                          onTap: () {
                            context
                                .read<AdminLoginCubit>()
                                .changeViewEvent(StringConstants.privacyPolicy);
                          },
                        ),
                        ListTile(
                          autofocus: true,
                          leading: const Icon(Icons.logout),
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
                                    userName: "",
                                    hotelName: "",
                                    checkOutDateValue: "",
                                    checkInDateValue: DateTime.now()
                                        .toString()
                                        .substring(0, 10)),
                          child: (AdminBookingPage()),
                        )
                      : (state is StateOnResponseSuccess &&
                              state.response ==
                                  StringConstants.reviewAppbarTitle)
                          ? BlocProvider<ReviewModerationCubit>(
                              create: (context) =>
                                  reviewSl<ReviewModerationCubit>(),
                              child: (ReviewModeration()),
                            )
                          : (state is StateOnResponseSuccess &&
                                  state.response == StringConstants.faq)
                              ? BlocProvider<FaqCubit>(
                                  create: (context) =>
                                      slFaqPage<FaqCubit>()..getFaqData(),
                                  child: (FaqPage()),
                                )
                              : (state is StateOnResponseSuccess &&
                                      state.response == StringConstants.aboutUs)
                                  ? BlocProvider<AboutUsCubit>(
                                      create: (context) =>
                                          slAboutUsPage<AboutUsCubit>()
                                            ..getAboutUsData(),
                                      child: (AboutUsPage()),
                                    )
                                  : (state is StateOnResponseSuccess &&
                                          state.response == StringConstants.tc)
                                      ? BlocProvider<TermsConditionCubit>(
                                          create: (context) =>
                                              slTcPage<TermsConditionCubit>()
                                                ..getTermsConditionData(),
                                          child: (TcPage()),
                                        )
                                      : (state is StateOnResponseSuccess &&
                                              state.response ==
                                                  StringConstants.privacyPolicy)
                                          ? BlocProvider<PrivacyPolicyCubit>(
                                              create: (context) =>
                                                  slPrivacyPage<
                                                      PrivacyPolicyCubit>()
                                                    ..getPrivacyPolicyData(),
                                              child: (PrivacyPolicyPage()),
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
