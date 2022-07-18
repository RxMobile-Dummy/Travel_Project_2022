import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../manager/cubit/tab_bar_cubit.dart';
import '../manager/cubit/tab_bar_state.dart';
import 'homescreen.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<TabBarCubit, TabBarState>(
      builder: (context, state) {
        if (state is OnItemTapState) {
          _selectedIndex = state.index;
          return SingleChildScrollView(
            child: Center(
              child: _widgetOptions().elementAt(state.index),
            ),
          );
        } else {
          return const Text("Not available");
        }
      },
    ), bottomNavigationBar: BlocBuilder<TabBarCubit, TabBarState>(
      builder: (context, state) {
        if (state is OnItemTapState) {
          _selectedIndex = state.index;
          return SalomonBottomBar(
            currentIndex: _selectedIndex,
            //selectedItemColor: MakeMyTripColors.accentColor,
            selectedColorOpacity: 0.3,
            onTap: BlocProvider.of<TabBarCubit>(context).onItemTap,
            items: [
              /// Home
              SalomonBottomBarItem(
                icon: const Icon(Icons.home),
                title: const Text("Home"),
                selectedColor: MakeMyTripColors.colorCwsPrimary,
              ),

              /// My Trip
              SalomonBottomBarItem(
                icon: const Icon(Icons.shop),
                title: const Text("My Trip"),
                selectedColor: MakeMyTripColors.colorCwsPrimary,
              ),

              /// WishList
              SalomonBottomBarItem(
                icon: const Icon(Icons.favorite),
                title: const Text("WishList"),
                selectedColor: MakeMyTripColors.colorCwsPrimary,
              ),

              /// Profile
              SalomonBottomBarItem(
                icon: const Icon(Icons.person),
                title: const Text("Profile"),
                selectedColor: MakeMyTripColors.colorCwsPrimary,
              ),
            ],
          );
        } else {
          return const Text("");
        }
      },
    ));
  }

  static List<Widget> _widgetOptions() => <Widget>[
        //View 1
        const HomeScreen(),
      ];
}
