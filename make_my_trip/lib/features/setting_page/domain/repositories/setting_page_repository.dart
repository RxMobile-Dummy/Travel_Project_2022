import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/setting_page/data/models/content_model.dart';
import 'package:make_my_trip/features/setting_page/data/models/user_details_model.dart';

import '../../data/models/faq_model.dart';

abstract class SettingPageRepository {
  Future<Either<Failures, UserDetailsModel>> getUserData();

  Future<Either<Failures, String>> updateImageFromGallery();

  Future<Either<Failures, String>> updateImageFromCamera();

  Future<Either<Failures, void>> updateUserData(Map<String, String> params);

  Future<Either<Failures, List<FaqModel>>> getFaq();

  Future<Either<Failures, List<ContentModel>>> getAboutUs();

  Future<Either<Failures, List<ContentModel>>> getTermsAndCondition();

  Future<Either<Failures, List<ContentModel>>> getPrivacyPolicy();
}
