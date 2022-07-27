import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/setting_page/data/models/user_details_model.dart';
import 'package:make_my_trip/features/setting_page/presentation/cubit/setting_page_cubit.dart';
import 'package:make_my_trip/features/setting_page/presentation/widgets/textField_widget.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

Widget settingProfileBody(BuildContext context) {
  TextEditingController _fullName = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  return BlocBuilder<SettingPageCubit, BaseState>(
    builder: (context, state) {
      if (state is StateOnKnownToSuccess<SettingPageData>) {
        UserDetailsModel? userDetailsModel = state.response.userValue;
        _fullName.text = userDetailsModel?.userName.toString() ??
            StringConstants.emptyString;
        _phoneNumber.text = userDetailsModel?.userPhoneNumber.toString() ==
                StringConstants.nullString
            ? StringConstants.emptyString
            : userDetailsModel?.userPhoneNumber.toString() ??
                StringConstants.emptyString;
        return Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 7),
                child: Text(StringConstants.userName,
                    style: AppTextStyles.hintTextStyle),
              ),
              TextFieldView(
                keyboardtype: TextInputType.text,
                textFieldViewController: _fullName,
                hintTextvar: StringConstants.enterName,
              ),
              15.verticalSpace,
              const Padding(
                padding: EdgeInsets.only(left: 7),
                child: Text(StringConstants.phone,
                    style: AppTextStyles.hintTextStyle),
              ),
              TextFieldView(
                keyboardtype: TextInputType.phone,
                textFieldViewController: _phoneNumber,
                hintTextvar: StringConstants.enterPhone,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            MakeMyTripColors.accentColor),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          StringConstants.update,
                          style: AppTextStyles.confirmButtonTextStyle,
                        ),
                      ),
                      onPressed: () {
                        var postData = {
                          StringConstants.userNameJson: _fullName.text,
                          StringConstants.userPhoneJson: _phoneNumber.text
                        };
                        context
                            .read<SettingPageCubit>()
                            .updateUserData(postData);
                      }),
                ),
              )
            ],
          ),
        );
      } else {
        return Center(child: Image.asset(ImagePath.serverFailImage));
      }
    },
  );
}
