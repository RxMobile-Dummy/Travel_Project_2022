import 'package:dartz/dartz.dart';
import 'package:make_my_trip/features/setting_page/data/models/user_details_model.dart';

import '../../../../core/failures/failures.dart';

abstract class UserDetailsRemoteDataSource {
  Future<Either<Failures, UserDetailsModel>> getUserData();

  Future<Either<Failures, void>> updateUserData(Map<String, String> postData);

  Future<Either<Failures, String>> updateImageFromGallery();

  Future<Either<Failures, String>> updateImageFromCamera();
}
