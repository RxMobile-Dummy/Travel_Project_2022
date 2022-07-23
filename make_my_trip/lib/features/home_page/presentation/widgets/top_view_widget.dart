import 'package:flutter/material.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/home_page/presentation/widgets/custom_icon_widget.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';

Widget topView(BuildContext context) {
  return Stack(
    children: [
      Container(
        color: MakeMyTripColors.customLightBlue,
        height: 200,
      ),
      Center(
        child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              height: 50,
              width: 200,
              child: Image.asset(
                ImagePath.appLogo,
                fit: BoxFit.cover,
              ),
            )),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 70, 20, 5),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: MakeMyTripColors.colorBlack,
                blurRadius: 5.0,
                spreadRadius: 0.3,
              )
            ],
            borderRadius: BorderRadius.circular(10),
            color: MakeMyTripColors.colorWhite,
          ),
          height: 170,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10.0, right: 10),
              child: Text(StringConstants.titleQuestion,
                  style: AppTextStyles.unselectedLabelStyle),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customIconWidget(context, Icons.business_sharp,
                      StringConstants.hotels, RoutesName.search),
                  customIconWidget(
                      context, Icons.maps_home_work, StringConstants.states),
                  customIconWidget(context, Icons.place, StringConstants.places)
                ],
              ),
            ),
          ]),
        ),
      )
    ],
  );
}
