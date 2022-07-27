import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/setting_page/data/models/user_details_model.dart';
import 'package:make_my_trip/features/setting_page/domain/use_cases/get_user_data_usecase.dart';
import 'package:make_my_trip/features/setting_page/domain/use_cases/update_image_usecase.dart';
import 'package:make_my_trip/features/setting_page/domain/use_cases/update_user_data_usecase.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';

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
    final res = await getUserDataUseCase.call(NoParams());
    res.fold(
        (l) => emit(StateNoData()),
        (r) => emit(StateOnKnownToSuccess(
            (state as StateOnKnownToSuccess<SettingPageData>)
                .response
                .copyWith(userValue: r))));
  }

  updateUserData(Map<String, String> postData) async {
    var nameErrorMsg =
        UserInfoValidation.nameValidation(postData.entries.first.value);
    var phoneErrorMsg =
        UserInfoValidation.phoneNumberValidation(postData.entries.last.value);
    if (nameErrorMsg != null) {
      Fluttertoast.showToast(msg: nameErrorMsg.toString());
    } else if (phoneErrorMsg != null) {
      Fluttertoast.showToast(msg: phoneErrorMsg.toString());
    } else {
      final res = await updateUserDataUseCase.call(postData);
      res.fold((l) => emit(StateErrorGeneral(l.toString())),
          (r) => Fluttertoast.showToast(msg: StringConstants.profileUpdate));
    }
  }

  getFromGallery() async {
    final res = await updateImageUseCase.call(NoParams());
    res.fold(
        (l) => emit(StateErrorGeneral(StringConstants.errorGallery)),
        (r) => emit(StateOnKnownToSuccess(
            (state as StateOnKnownToSuccess<SettingPageData>)
                .response
                .copyWith(imageValue: r))));
  }

  getFromCamera() async {
    final res = await updateImageUseCase.callImagefromCamera(NoParams());
    res.fold(
        (l) => emit(StateErrorGeneral(StringConstants.errorCamera)),
        (r) => emit(StateOnKnownToSuccess(
            (state as StateOnKnownToSuccess<SettingPageData>)
                .response
                .copyWith(imageValue: r))));
  }
}

class SettingPageData {
  UserDetailsModel? userValue;
  String? imageValue;
  String? error;

  SettingPageData({this.userValue, this.imageValue, this.error});

  SettingPageData copyWith(
          {UserDetailsModel? userValue, String? imageValue, String? error}) =>
      SettingPageData(
          error: error ?? this.error,
          userValue: userValue ?? this.userValue,
          imageValue: imageValue ?? this.imageValue);
}
