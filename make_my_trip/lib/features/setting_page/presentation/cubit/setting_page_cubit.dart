import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/login/domain/model/user_model.dart';
import 'package:make_my_trip/features/setting_page/data/models/user_details_model.dart';
import 'package:make_my_trip/features/setting_page/domain/use_cases/get_user_data_usecase.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';

class SettingPageCubit extends Cubit<BaseState> {
  GetUserDataUseCase getUserDataUseCase;
  SettingPageCubit(this.getUserDataUseCase) : super(StateInitial());

  getUserData() async {
    print("mycubit");
    final res = await getUserDataUseCase.call(NoParams());
    res.fold((l) => emit(StateNoData()),
        (r) => emit(StateOnKnownToSuccess<dynamic>(r)));
  }

  updateProfile(String name, String email, String phone) {
    const pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    final regExp = RegExp(pattern);

    if (name == null || name.isEmpty || name.trim().isEmpty) {
      emit(StateErrorGeneral(StringConstants.userName));
    } else if (name.contains(RegExp(r'[0-9]'))) {
      emit(StateErrorGeneral(StringConstants.messageInvalidName));
    } else if (phone == null || phone.isEmpty || phone.trim().isEmpty) {
      emit(StateErrorGeneral(StringConstants.messageEmptyPhoneNo));
    } else if (!regExp.hasMatch(phone)) {
      emit(StateErrorGeneral(StringConstants.messageInvalidPhoneNo));
    } else {
      emit(StateOnKnownToSuccess<void>(null));
    }
  }

  getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      emit(StateOnKnownToSuccess<String>(pickedFile.path));
    } else {
      emit(StateErrorGeneral("Error GetFromGallery"));
    }
  }

  getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      emit(StateOnKnownToSuccess<String>(pickedFile.path));
    } else {
      emit(StateErrorGeneral("Error GetFromCamera"));
    }
  }
}
  //
  // getEmailById(String email) async {
  //   final res = await _getUserByEmailUseCase.call(EmailParams(email: email));
  //   res.fold((failure) {
  //     print(failure);
  //   }, (success) {
  //     List<UserInfo> list = [];
  //     list.add(success);
  //     emit(UserinfoSuccess(userdata: list));
  //   });
  // }


