import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import '../../../../utils/constants/string_constants.dart';
import '../widgets/setting_body.dart';
import '../widgets/setting_header.dart';

class ProfileDetailPage extends StatelessWidget {
  const ProfileDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MakeMyTripColors.color10gray,
        shadowColor: MakeMyTripColors.colorBlack,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: MakeMyTripColors.colorBlack,
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          StringConstants.profile,
          style: AppTextStyles.infoContentStyle,
        ),
        actions: [
          const SizedBox(
            height: 40,
            width: 40,
            child: Center(
                child: Text(
              StringConstants.done,
              style: AppTextStyles.infoContentStyle,
            )),
          ),
          20.horizontalSpace
        ],
      ),
      body: Container(
          color: MakeMyTripColors.color10gray,
          child: ListView(children: const [Header(), SettingBody()])),
    );
  }
}
