

import 'package:bloc/bloc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/setting_page/domain/use_cases/get_user_data_usecase.dart';
import 'package:make_my_trip/features/setting_page/domain/use_cases/update_image_usecase.dart';
import 'package:make_my_trip/features/setting_page/domain/use_cases/update_user_data_usecase.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/validators/user_info/user_information_validations.dart';

class SettingPageCubit extends Cubit<BaseState> {
  GetUserDataUseCase getUserDataUseCase;
  UpdateImageUseCase updateImageUseCase;
  UpdateUserDataUseCase updateUserDataUseCase;

  SettingPageCubit(this.getUserDataUseCase, this.updateImageUseCase,
      this.updateUserDataUseCase)
      : super(StateOnKnownToSuccess<SettingPageData>(SettingPageData())) {
    getUserData();
  }

  getUserData() async {
    emit(StateOnKnownToSuccess(
        (state as StateOnKnownToSuccess<SettingPageData>)
            .response
            . copyWith(profileLoading: true)));
    final res = await getUserDataUseCase.call(NoParams());
    res.fold(
        (l) => getUserData(),
        (r) => emit(StateOnKnownToSuccess(
            (state as StateOnKnownToSuccess<SettingPageData>)
                .response
                .copyWith(userValue: r,profileLoading: false))
           ));
  }

  updateUserData(Map<String, String> postData) async {

    var nameErrorMsg =
        UserInfoValidation.nameValidation(postData.entries.first.value);
    var phoneErrorMsg =
        UserInfoValidation.phoneNumberValidation(postData.entries.last.value);
    if(postData.entries.first.value.length>30){
      Fluttertoast.showToast(msg: "Please enter a name less than 30");
    }
    else if (nameErrorMsg != null) {
      Fluttertoast.showToast(msg: nameErrorMsg.toString());
    } else if (phoneErrorMsg != null) {
      Fluttertoast.showToast(msg: phoneErrorMsg.toString());
    }
    else {
      final res = await updateUserDataUseCase.call(postData);
      res.fold((l) => emit(StateErrorGeneral(l.toString())),
          (r) {
        Fluttertoast.showToast(msg: StringConstants.profileUpdate);
      });
    }
  }

  getFromGallery() async {
    emit(StateOnKnownToSuccess(
        (state as StateOnKnownToSuccess<SettingPageData>)
            .response
            .copyWith(profileLoading: true)));
    final res = await updateImageUseCase.call(NoParams());
    var userValue = await getUserData();
    res.fold(
        (l) => emit(StateErrorGeneral(StringConstants.errorGallery)),
        (r) => emit(StateOnKnownToSuccess(
            (state as StateOnKnownToSuccess<SettingPageData>)
                .response
                .copyWith(imageValue: r, userValue: userValue,profileLoading: false))));
  }

  getFromCamera() async {
    emit(StateOnKnownToSuccess(
        (state as StateOnKnownToSuccess<SettingPageData>)
            .response
            .copyWith(profileLoading: true)));
    final res = await updateImageUseCase.callImageFromCamera(NoParams());
    var userValue = await getUserData();
    res.fold(
        (l) => emit(StateErrorGeneral(StringConstants.errorCamera)),
        (r) => emit(StateOnKnownToSuccess(
            (state as StateOnKnownToSuccess<SettingPageData>)
                .response
                .copyWith(imageValue: r, userValue: userValue,profileLoading: false))));
  }

  callNumber() async {
    const number = StringConstants.helpLineNumber; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
    return res;
  }

  sendingMails() async {
    final Email email = Email(
      subject: StringConstants.emailSubject,
      body: StringConstants.emailBody,
      recipients: ['rxtrainee22@gmail.com'],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }
}
