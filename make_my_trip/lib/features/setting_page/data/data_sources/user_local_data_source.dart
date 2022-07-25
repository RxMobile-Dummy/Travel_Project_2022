import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/setting_page/data/models/user_details_model.dart';

abstract class UserDetailsLocalDataSource {
  Future<Either<Failures, String>> updateImagefromGallery();
  Future<Either<Failures, String>> updateImagefromCamera();
}
