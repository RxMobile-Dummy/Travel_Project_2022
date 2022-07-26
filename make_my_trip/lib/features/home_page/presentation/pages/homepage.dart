import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/features/login/login_injection_container.dart';
import 'package:make_my_trip/features/login/presentation/cubit/login_cubit.dart';
import 'package:make_my_trip/features/login/presentation/pages/login_page.dart';
import 'package:make_my_trip/features/user_history/presentation/cubit/user_history_cubit.dart';
import 'package:make_my_trip/features/user_history/presentation/pages/user_history_page.dart';
import 'package:make_my_trip/features/user_history/user_history_injection_container.dart';
import 'package:make_my_trip/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:make_my_trip/features/wishlist/presentation/pages/wishlist_page.dart';
import 'package:make_my_trip/features/wishlist/wishlist_injection_container.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../../../../core/navigation/route_info.dart';
import '../cubit/tab_bar_cubit.dart';
import 'homescreen.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TabBarCubit, BaseState>(
      listener: (context, state) {
        print(state);
        if (state is Unauthenticated) {
          Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.login, (route) => true,arguments: {"route_name":RoutesName.home});
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
            bottomNavigationBar: SalomonBottomBar(
              items: <SalomonBottomBarItem>[
                SalomonBottomBarItem(
                    icon: const Icon(Icons.home), title: const Text("Home")),
                SalomonBottomBarItem(
                  icon: const Icon(Icons.shop),
                  title: const Text("Bookings"),
                ),
                SalomonBottomBarItem(
                  icon: const Icon(Icons.favorite),
                  title: const Text("Favorite"),
                ),
                SalomonBottomBarItem(
                  icon: const Icon(Icons.person),
                  title: const Text("Profile"),
                )
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: MakeMyTripColors.accentColor,
              onTap: (index) {
                var searchState = context.read<TabBarCubit>().state;
                print(searchState);
                if (searchState is Unauthenticated && index != 0) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RoutesName.login, (route) => true,arguments: {"route_name":RoutesName.home});
                } else {
                  BlocProvider.of<TabBarCubit>(context).checkAnonymous(index);
                }
              },
            ));
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
    BlocProvider(
      create: (context) =>
      wishListSl<WishListCubit>()..getWishListCubitData(),
      child: WishListPage(),
    ),
      ];
}
