import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
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
    // void _onItemTapped(int index) {
    // BlocProvider.of<TabBarCubit>(context).OnItemTap(_selectedIndex);
    //  }
    return Scaffold(body: BlocBuilder<TabBarCubit, TabBarState>(
      builder: (context, state) {
        if (state is OnItemTapState) {
          _selectedIndex = state.index;
          return _widgetOptions().elementAt(state.index);
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
          return Text("");
        }
      },
    ));
  }

  static List<Widget> _widgetOptions() => <Widget>[
        //View 1
        HomeScreen(),
        HomeScreen(),
        HomeScreen(),
        BlocProvider(
          create: (context) => sl<LoginCubit>(),
          child: LoginPage(),
        )
        //View 4
      ];
}
