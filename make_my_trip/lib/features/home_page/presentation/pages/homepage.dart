import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../manager/cubit/tab_bar_cubit.dart';
import 'homescreen.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<TabBarCubit, BaseState>(
      builder: (context, state) {
        if (state is StateOnSuccess) {
          _selectedIndex = state.response;
          return SingleChildScrollView(
            child: Center(
              child: _widgetOptions().elementAt(state.response),
            ),
          );
        } else {
          return const Text("Not available");
        }
      },
    ), bottomNavigationBar: BlocBuilder<TabBarCubit, BaseState>(
      builder: (context, state) {
        if (state is StateOnSuccess) {
          _selectedIndex = state.response;
          return SalomonBottomBar(
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
            onTap: BlocProvider.of<TabBarCubit>(context).OnItemTap,
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
        const HomeScreen(),
        const HomeScreen(),
        const HomeScreen(),
      ];
}
