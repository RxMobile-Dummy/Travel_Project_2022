import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/setting_page/presentation/cubit/setting_page_cubit.dart';
import 'package:make_my_trip/features/setting_page/presentation/pages/settings_page.dart';
import 'package:make_my_trip/features/user/presentation/cubit/user_cubit.dart';
import 'package:make_my_trip/features/user/user_injection_container.dart';
import 'package:make_my_trip/features/user_history/presentation/cubit/user_history_cubit.dart';
import 'package:make_my_trip/features/user_history/presentation/pages/user_history_page.dart';
import 'package:make_my_trip/features/user_history/user_history_injection_container.dart';
import 'package:make_my_trip/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:make_my_trip/features/wishlist/presentation/pages/wishlist_page.dart';
import 'package:make_my_trip/features/wishlist/wishlist_injection_container.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import '../../../../core/internet/internet_cubit.dart';
import '../../../../core/navigation/route_info.dart';
import '../../../../utils/widgets/progress_loader.dart';
import '../cubit/homepage_cubit.dart';
import '../cubit/tab_bar_cubit.dart';
import 'homescreen.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InternetCubit, BaseState>(
      listener: (context, state) {
        if (state is InternetLoading) {
          ProgressDialog.showLoadingDialog(context,
              message: StringConstants.interNetDsc);
        }
        if (state is InternetDisconnected) {
          ProgressDialog.showLoadingDialog(context,
              message: StringConstants.interNetDsc);
        }
        if (state is InternetConnected) {
          context.read<HomepageCubit>()
            ..getImagesApi()
            ..getToursApi();
          ProgressDialog.hideLoadingDialog(context);
        }
      },
      builder: (context, state) {
        return BlocConsumer<TabBarCubit, BaseState>(
          listener: (context, state) {
            if (state is Unauthenticated) {
              Navigator.pushNamedAndRemoveUntil(
                  context, RoutesName.login, (route) => true,
                  arguments: {"route_name": RoutesName.home});
            }
          },
          builder: (context, state) {
            if (state is StateOnSuccess) {
              _selectedIndex = state.response;
            }
            return Scaffold(
                body: Center(
                  child: _widgetOptions().elementAt(_selectedIndex),
                ),
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  items: [
                    BottomNavigationBarItem(
                        activeIcon: SvgPicture.asset(
                          ImagePath.homeIcon,
                          color: MakeMyTripColors.colorBlack,
                        ),
                        icon: SvgPicture.asset(
                          ImagePath.homeLineIcon,
                          color: MakeMyTripColors.colorBlack,
                        ),
                        label: StringConstants.homeTxt),
                    BottomNavigationBarItem(
                        activeIcon: SvgPicture.asset(
                          ImagePath.bookingFill,
                          color: MakeMyTripColors.colorBlack,
                        ),
                        icon: SvgPicture.asset(
                          ImagePath.bookingLine,
                          color: MakeMyTripColors.colorBlack,
                        ),
                        label: StringConstants.bookingTxt),
                    BottomNavigationBarItem(
                        activeIcon: SvgPicture.asset(
                          ImagePath.likeFillIcon,
                          color: MakeMyTripColors.colorBlack,
                        ),
                        icon: SvgPicture.asset(
                          ImagePath.likeLineIcon,
                          color: MakeMyTripColors.colorBlack,
                        ),
                        label: StringConstants.favouriteTxt),
                    BottomNavigationBarItem(
                        activeIcon: SvgPicture.asset(
                          ImagePath.profilrFilIcon,
                          color: MakeMyTripColors.colorBlack,
                        ),
                        icon: SvgPicture.asset(
                          ImagePath.profilrLineIcon,
                          color: MakeMyTripColors.colorBlack,
                        ),
                        label: StringConstants.profileTxt),
                  ],
                  showUnselectedLabels: true,
                  showSelectedLabels: true,
                  unselectedItemColor: MakeMyTripColors.colorBlack,
                  currentIndex: _selectedIndex,
                  selectedItemColor: MakeMyTripColors.colorBlack,
                  onTap: (index) {
                    BlocProvider.of<TabBarCubit>(context).checkAnonymous(index);
                  },
                ));
          },
        );
      },
    );
  }

  static List<Widget> _widgetOptions() => <Widget>[
        //View 1
        const HomeScreen(),
        BlocProvider(
          create: (context) =>
              historyListSl<UserHistoryCubit>()..getUserHistoryData(),
          child: UserHistoryPage(),
        ),
        BlocProvider(
          create: (context) =>
              wishListSl<WishListCubit>()..getWishListCubitData(),
          child: WishListPage(),
        ),
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => wishListSl<SettingPageCubit>(),
            ),
            BlocProvider(
              create: (context) => userSl<UserCubit>(),
            ),
          ],
          child: SettingsPage(),
        )
      ];
}
