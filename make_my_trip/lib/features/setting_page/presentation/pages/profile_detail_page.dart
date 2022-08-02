import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/features/home_page/presentation/pages/homepage.dart';
import 'package:make_my_trip/features/setting_page/presentation/pages/settings_page.dart';
import 'package:make_my_trip/features/setting_page/presentation/widgets/common_appbar_widget.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../home_page/home_page_injection_container.dart';
import '../../../home_page/presentation/cubit/homepage_cubit.dart';
import '../../../home_page/presentation/cubit/tab_bar_cubit.dart';
import '../widgets/settingProfile_body.dart';
import '../widgets/settingProfile_header.dart';

class ProfileDetailPage extends StatelessWidget {
  const ProfileDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return _moveToScreen2(context);

      },
      child: Scaffold(
        backgroundColor: MakeMyTripColors.colorWhite,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: MakeMyTripColors.colorWhite,
          leading: IconButton(
              onPressed: () {
               Navigator.of(context).pop(MaterialPageRoute(builder: (context)=>MultiBlocProvider(
                                      providers: [
                                        BlocProvider.value(
                                            value: slHomePage<HomepageCubit>()
                                              ..getToursApi()
                                              ..getImagesApi()),
                                        BlocProvider.value(value: slHomePage<TabBarCubit>())
                                      ],
                                      child: HomePage(i: 3),
                                    )));
               //  Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context)=>MultiBlocProvider(
               //        providers: [
               //          BlocProvider.value(
               //              value: slHomePage<HomepageCubit>()
               //                ..getToursApi()
               //                ..getImagesApi()),
               //          BlocProvider.value(value: slHomePage<TabBarCubit>())
               //        ],
               //        child: HomePage(i: 3),
               //      )));
                 // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MultiBlocProvider(
                 //   providers: [
                 //     BlocProvider.value(
                 //         value: slHomePage<HomepageCubit>()
                 //           ..getToursApi()
                 //           ..getImagesApi()),
                 //     BlocProvider.value(value: slHomePage<TabBarCubit>())
                 //   ],
                 //   child: HomePage(3),
                 // )), (route) => false);
                // Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context)=>MultiBlocProvider(
                //       providers: [
                //         BlocProvider.value(
                //             value: slHomePage<HomepageCubit>()
                //               ..getToursApi()
                //               ..getImagesApi()),
                //         BlocProvider.value(value: slHomePage<TabBarCubit>())
                //       ],
                //       child: HomePage(3),
                //     )));

              },
              icon: (Platform.isAndroid)
                  ? const Icon(
                Icons.arrow_back_outlined,
              )
                  : const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color:
                  MakeMyTripColors.colorBlack

              )),
          title: const Text(StringConstants.userEditProfile,
              style: TextStyle(
                  color: MakeMyTripColors.colorBlack,
                  fontWeight: FontWeight.bold)),
        ),
        body: Container(
            color: MakeMyTripColors.colorWhite,
            child: SingleChildScrollView(
              child: Column(children: [
                settingProfileHeader(context),
                settingProfileBody(context)
              ]),
            )),
      ),
    );
  }
}

_moveToScreen2(BuildContext context) {
  return  Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context)=>MultiBlocProvider(
    providers: [
      BlocProvider.value(
          value: slHomePage<HomepageCubit>()
            ..getToursApi()
            ..getImagesApi()),
      BlocProvider.value(value: slHomePage<TabBarCubit>())
    ],
    child: HomePage(i: 3,),
  )));
}
