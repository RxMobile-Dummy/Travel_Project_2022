import 'package:make_my_trip_admin_panel/utils/extensions/common/common_extensions.dart';

import '../../constants/string_constants.dart';

class UserInfoValidation {
  static String? nameValidation(String? string) {
    if (string == null || string.isEmpty || string.trim().isEmpty) {
      return StringConstants.messageEmptyName;
    } else if (string.contains(RegExp(r'[0-9]'))) {
      return StringConstants.messageInvalidName;
    }
    return null;
  }

  static String? phoneNumberValidation(String? string) {
    const pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    final regExp = RegExp(pattern);
    if (string == null || string.isEmpty || string.trim().isEmpty) {
      return StringConstants.messageEmptyPhoneNo;
    } else if (!regExp.hasMatch(string)) {
      return StringConstants.messageInvalidPhoneNo;
    }
    return null;
  }

  static String? pinCodeValidation(String? string) {
    if (string == null || string.isEmpty || string.trim().isEmpty) {
      return StringConstants.messageEmptyPinCode;
    } else if (!(string.isNumericOnly() && string.length == 6)) {
      return StringConstants.messageInvalidPinCode;
    }
    return null;
  }

  static String? addressValidation(String? string) {
    if (string == null || string.isEmpty || string.trim().isEmpty) {
      return StringConstants.messageEmptyAddress;
    }
    return null;
  }

  static String? emailAddressValidation(String? string) {
    if (string == null || string.isEmpty || string.trim().isEmpty) {
      return StringConstants.messageEmptyEmailAddress;
    } else if (!string.isEmail()) {
      return StringConstants.messageInvalidEmailAddress;
    }
    return null;
  }

  static String? passwordValidation(String? string) {
    if (string == null || string.isEmpty || string.trim().isEmpty) {
      return StringConstants.messageEmptyPassword;
    } else if (string.length < 6) {
      return StringConstants.messageInvalidPassword;
    }
    return null;
  }
}
