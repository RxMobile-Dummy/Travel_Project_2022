import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/login/domain/model/user_model.dart';
import 'package:make_my_trip/features/setting_page/data/models/user_details_model.dart';

abstract class Settingpagerepository {
  Future<Either<Failures, UserDetailsModel>> getUserData();
}
