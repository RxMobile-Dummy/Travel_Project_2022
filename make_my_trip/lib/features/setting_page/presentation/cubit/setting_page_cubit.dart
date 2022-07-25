import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/home_page/presentation/manager/cubit/homepage_cubit.dart';
import 'package:make_my_trip/features/login/domain/model/user_model.dart';
import 'package:make_my_trip/features/setting_page/data/models/user_details_model.dart';
import 'package:make_my_trip/features/setting_page/domain/use_cases/get_user_data_usecase.dart';
import 'package:make_my_trip/features/setting_page/domain/use_cases/update_image_usecase.dart';
import 'package:make_my_trip/features/setting_page/domain/use_cases/update_user_data_usecase.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';

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
    print("mycubit");
    final res = await getUserDataUseCase.call(NoParams());
    res.fold(
        (l) => emit(StateNoData()),
        (r) => emit(StateOnKnownToSuccess(
            (state as StateOnKnownToSuccess<SettingPageData>)
                .response
                .copyWith(userValue: r))));
  }

  updateUserData(Map<String, String> postData) async {
    const pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    final regExp = RegExp(pattern);
    await updateUserDataUseCase.call(postData);
    // if (name == null || name.isEmpty || name.trim().isEmpty) {
    //   emit(StateErrorGeneral(StringConstants.userName));
    // } else if (name.contains(RegExp(r'[0-9]'))) {
    //   emit(StateErrorGeneral(StringConstants.messageInvalidName));
    // } else if (phone == null || phone.isEmpty || phone.trim().isEmpty) {
    //   emit(StateErrorGeneral(StringConstants.messageEmptyPhoneNo));
    // } else if (!regExp.hasMatch(phone)) {
    //   emit(StateErrorGeneral(StringConstants.messageInvalidPhoneNo));
    // } else {
    //   emit(StateOnKnownToSuccess<void>(null));
    // }
  }

  getFromGallery() async {
    final res = await updateImageUseCase.call(NoParams());
    res.fold(
        (l) => emit(StateErrorGeneral("Error GetFromGallery")),
        (r) => emit(StateOnKnownToSuccess(
            (state as StateOnKnownToSuccess<SettingPageData>)
                .response
                .copyWith(imageValue: r))));
  }

  getFromCamera() async {
    final res = await updateImageUseCase.callImagefromCamera(NoParams());
    res.fold(
        (l) => emit(StateErrorGeneral("Error GetFromCamera")),
        (r) => emit(StateOnKnownToSuccess(
            (state as StateOnKnownToSuccess<SettingPageData>)
                .response
                .copyWith(imageValue: r))));
    //   XFile? pickedFile = await ImagePicker().pickImage(
    //     source: ImageSource.camera,
    //     maxWidth: 1800,
    //     maxHeight: 1800,
    //   );
    //   if (pickedFile != null) {
    //     emit(StateOnKnownToSuccess<dynamic>(pickedFile.path));
    //   } else {
    //     emit(StateErrorGeneral("Error GetFromCamera"));
    //   }
    // }
  }
}

class SettingPageData {
  UserDetailsModel? userValue;
  String? imageValue;

  SettingPageData({this.userValue, this.imageValue});

  SettingPageData copyWith({
    UserDetailsModel? userValue,
    String? imageValue,
  }) =>
      SettingPageData(
          userValue: userValue ?? this.userValue,
          imageValue: imageValue ?? this.imageValue);
}
