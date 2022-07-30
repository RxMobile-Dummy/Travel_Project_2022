
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/setting_page/presentation/cubit/setting_page_cubit.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

class CustomerSupportPage extends StatelessWidget {
  const CustomerSupportPage({Key? key}) : super(key: key);

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
            style: TextStyle(
                color: MakeMyTripColors.colorBlack,
                fontWeight: FontWeight.bold),
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
              Image.asset(ImagePath.helpImage,height: 350,width: 350),
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
                        onTap: (){
                          context.read<SettingPageCubit>().callNumber();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:   [
                              Text(StringConstants.helpCall, style: AppTextStyles.infoContentStyle),
                              Text(StringConstants.helpPhoneNumber,
                                  style: TextStyle(color: MakeMyTripColors.colorCwsPrimary,fontWeight: FontWeight.bold))
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
                        onTap: (){
                          context.read<SettingPageCubit>().sendingMails();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:   [
                              Text(StringConstants.helpEmail, style: AppTextStyles.infoContentStyle),
                              Text(StringConstants.helpEmailAddress,
                                  style : TextStyle(color: MakeMyTripColors.colorCwsPrimary,fontWeight: FontWeight.bold))
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
