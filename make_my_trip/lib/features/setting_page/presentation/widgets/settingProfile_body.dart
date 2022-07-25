import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/setting_page/data/models/user_details_model.dart';
import 'package:make_my_trip/features/setting_page/presentation/cubit/setting_page_cubit.dart';
import 'package:make_my_trip/features/setting_page/presentation/widgets/textField_widget.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:make_my_trip/utils/widgets/common_primary_button.dart';

import 'textField_email_widget.dart';

Widget SettingProfileBody(BuildContext context) {
  String error = "";
  TextEditingController _fullname = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  return BlocBuilder<SettingPageCubit, BaseState>(
    builder: (context, state) {
      //context.read<SettingPageCubit>().getUserData();
      if (state is StateOnKnownToSuccess<SettingPageData>) {
        UserDetailsModel? userDetailsModel = state.response.userValue;
        _fullname.text = userDetailsModel?.userName.toString() ?? " ";
        _phoneNumber.text = userDetailsModel?.userPhoneNumber.toString() ?? "";
        return Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 7),
                child: Text(StringConstants.userName,
                    style: TextStyle(
                        color: MakeMyTripColors.color50gray,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
              TextFieldView(
                keyboardtype: TextInputType.text,
                textFieldViewController: _fullname,
                hintTextvar: "Enter User Name",
              ),
              15.verticalSpace,
              const Padding(
                padding: EdgeInsets.only(left: 7),
                child: Text(StringConstants.phone,
                    style: TextStyle(
                        color: MakeMyTripColors.color50gray,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
              TextFieldView(
                keyboardtype: TextInputType.phone,
                textFieldViewController: _phoneNumber,
                hintTextvar: "Enter Phone Number",
              ),
              BlocBuilder<SettingPageCubit, BaseState>(
                  builder: (context, state) {
                if (state is StateErrorGeneral) {
                  error = state.errorMessage;
                } else if (state is StateOnKnownToSuccess) {
                  error = "";
                }
                return Padding(
                  padding: const EdgeInsets.only(right: 10, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        error,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                );
              }),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            MakeMyTripColors.accentColor),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          StringConstants.update,
                          style: AppTextStyles.confirmButtonTextStyle,
                        ),
                      ),
                      onPressed: () {
                        var postData = {
                          "user_name": _fullname.text,
                          "user_phone_number": _phoneNumber.text
                        };
                        context
                            .read<SettingPageCubit>()
                            .updateUserData(postData);
                      }

                      //   .updateProfile(_fullname , _phoneNumber);
                      // BlocProvider.of<SettingPageCubit>(context).updateProfile(
                      //     _fullname.text, _email.text, _phoneNumber.text);

                      ),
                ),
              )
            ],
          ),
        );
      } else
        return Container();
    },
  );
}

//
// 18.verticalSpace,
// FromField(
// labelName: StringConstants.phone,
// data: "",
// onTap: () {
// showDialog(
// context: context,
// builder: (context) {
// return const UpdateDialog(
// name: StringConstants.phone,
// data: "Enter Phone",
// );
// }).then((value) {
// if (value is String && value.isNotEmpty) {}
// });
// },
// ),
