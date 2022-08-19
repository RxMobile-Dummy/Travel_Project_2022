import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/config/firebase/remote_config.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/setting_page/presentation/cubit/information_page_cubit.dart';
import 'package:make_my_trip/features/setting_page/presentation/cubit/setting_page_cubit.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

class CustomerSupportPage extends StatelessWidget {
  CustomerSupportPage({Key? key}) : super(key: key);

  final String number =
      remoteConfigManager?.getStringData("number") ?? "7202033879";
  final String email =
      remoteConfigManager?.getStringData("email") ?? "rxtrainee22@gmail.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MakeMyTripColors.colorWhite,
      appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back,
                  color: MakeMyTripColors.colorBlack)),
          backgroundColor: MakeMyTripColors.colorWhite,
          elevation: 0,
          //backgroundColor: Colors.transparent,
          title: Text(
            StringConstants.helpAppbar,
          )),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Text(
                StringConstants.helpTitle,
                style: AppTextStyles.labelStyle,
              ),
              Text(
                StringConstants.helpSubTitle,
                style: AppTextStyles.labelDetails,
              ),
              20.verticalSpace,
              Image.asset(ImagePath.helpImage, height: 350, width: 350),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Image.asset(ImagePath.helpSupportCall,
                            width: 25, height: 40),
                      ),
                      30.horizontalSpace,
                      GestureDetector(
                        onTap: () {
                          context.read<InformationPageCubit>().callNumber(
                              number.isNotEmpty ? number : "7202033879");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(StringConstants.helpCall,
                                  style: AppTextStyles.infoContentStyle),
                              Text(number.isNotEmpty ? number : "7202033879",
                                  style: AppTextStyles.infoContentStyle2
                                      .copyWith(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              10.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Image.asset(ImagePath.helpSupportEmail,
                            width: 25, height: 40),
                      ),
                      30.horizontalSpace,
                      GestureDetector(
                        onTap: () {
                          context.read<InformationPageCubit>().sendingMails(
                              email.isNotEmpty
                                  ? email
                                  : "rxtrainee22@gmail.com");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(StringConstants.emailTxt,
                                  style: AppTextStyles.infoContentStyle),
                              Text(
                                  email.isNotEmpty
                                      ? email
                                      : "rxtrainee22@gmail.com",
                                  style: AppTextStyles.infoContentStyle2
                                      .copyWith(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14))
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
      ),
    );
  }
}
