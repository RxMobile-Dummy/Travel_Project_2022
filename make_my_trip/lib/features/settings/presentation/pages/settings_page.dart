import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/features/settings/presentation/pages/profile_detail_page.dart';
import 'package:make_my_trip/features/settings/presentation/widgets/custom_list_tile.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import '../../../../core/theme/text_styles.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.arrow_back,
                      color: MakeMyTripColors.colorBlack),
                  const Text(
                    StringConstants.setting,
                    style: AppTextStyles.unselectedLabelStyle,
                  ),
                  18.horizontalSpace
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: MakeMyTripColors.color10gray,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: ListView(
                  children: [
                    20.verticalSpace,
                    customHeading(StringConstants.editProfile),
                    ClipRRect(
                      child: Container(
                        height: 50,
                        color: MakeMyTripColors.colorWhite,
                        child: Row(
                          children: <Widget>[
                            18.horizontalSpace,
                            const SizedBox(
                              width: 30,
                              height: 40,
                              child: CircleAvatar(
                                backgroundColor: MakeMyTripColors.color30gray,
                                child: Icon(Icons.person),
                              ),
                            ),
                            10.horizontalSpace,
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const <Widget>[
                                  Text(
                                    StringConstants.profile,
                                    style: AppTextStyles.infoContentStyle,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const ProfileDetailPage()));
                              },
                              child: const Icon(Icons.arrow_forward_ios,
                                  color: Colors.blue),
                            ),
                            8.horizontalSpace
                          ],
                        ),
                      ),
                    ),
                    customDivider(),
                    customHeading("To be added"),
                    CustomListTile("Wishlist", Icons.favorite),
                    customDivider(),
                    CustomListTile("My Trips", Icons.car_rental),
                    customDivider(),
                    customHeading("General"),
                    CustomListTile("Privacy and Security", Icons.security),
                    customDivider(),
                    CustomListTile("Help and Security", Icons.help),
                    customDivider(),
                    CustomListTile("About Us", Icons.info),
                    customDivider(),
                    20.verticalSpace,
                    Container(
                      height: 50,
                      color: MakeMyTripColors.colorWhite,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.logout,
                                  color: MakeMyTripColors.colorBlack,
                                ),
                                10.horizontalSpace,
                                const Text(
                                  StringConstants.logout,
                                  style: AppTextStyles.infoContentStyle,
                                )
                              ],
                            ),
                            const Text(
                              "Version info",
                              style: AppTextStyles.infoContentStyle,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget customDivider() {
  return Container(
    height: 2,
    color: MakeMyTripColors.colorBlack,
  );
}

Widget customHeading(String heading) {
  return Padding(
    padding: const EdgeInsets.only(left: 16.0, bottom: 10, top: 20),
    child: Text(
      heading,
      style: AppTextStyles.infoContentStyle,
    ),
  );
}
