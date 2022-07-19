import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:make_my_trip/features/login/presentation/pages/login_page.dart';

import '../../../../injection_container.dart';
import '../../../login/presentation/cubit/login_cubit.dart';
import '../manager/cubit/tab_bar_cubit.dart';
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
          return Text("Not available");
        }
      },
    ), bottomNavigationBar: BlocBuilder<TabBarCubit, TabBarState>(
      builder: (context, state) {
        if (state is OnItemTapState) {
          _selectedIndex = state.index;
          return SalomonBottomBar(
            items:  <SalomonBottomBarItem>[
              SalomonBottomBarItem(
                  icon: Icon(Icons.home),

                  title:Text("Home")),
              SalomonBottomBarItem(
                  icon: Icon(Icons.shop),

                  title:Text("Bookings"),),
              SalomonBottomBarItem(
                icon: Icon(Icons.favorite),

                title:Text("Favorite"),),
              SalomonBottomBarItem(
                icon: Icon(Icons.home),

                title:Text("Profile"),)

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

  static List<Widget> _widgetOptions() =>
      <Widget>[
        //View 1
        HomeScreen(),
      ];
}
