import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/features/home_page/presentation/manager/cubit/homepage_cubit.dart';

import '../../data/data_sources/images_datasource_impl.dart';
import '../../data/repositories/image_repository_impl.dart';
import '../../domain/use_cases/image_usecase.dart';
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
          return BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                  backgroundColor: MakeMyTripColors.colorBlack),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shop), label: "Your cart"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: "Your Favorite"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile"),
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

        HomeScreen(),
      ];
}
