import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/login/domain/model/user_model.dart';
import 'package:make_my_trip/features/setting_page/data/data_sources/user_details_remote_data_source.dart';
import 'package:make_my_trip/features/setting_page/data/data_sources/user_local_data_source.dart';
import 'package:make_my_trip/features/setting_page/data/models/user_details_model.dart';
import 'package:make_my_trip/features/setting_page/domain/repositories/setting_page_repository.dart';

class Settingpagerepositoryimpl implements Settingpagerepository {
  UserDetailsRemoteDataSource userDetailsRemoteDataSource;
  UserDetailsLocalDataSource userDetailsLocalDataSource;

  Settingpagerepositoryimpl(
      this.userDetailsRemoteDataSource, this.userDetailsLocalDataSource);
  @override
  Future<Either<Failures, UserDetailsModel>> getUserData() async {
    return await userDetailsRemoteDataSource.getUserData();
  }

  @override
  Future<Either<Failures, String>> updateImagefromGallery() async {
    return await userDetailsLocalDataSource.updateImagefromGallery();
  }

  @override
  Future<Either<Failures, String>> updateImagefromCamera() async {
    return await userDetailsLocalDataSource.updateImagefromCamera();
  }

  @override
  Future<Either<Failures, void>> updateUserData(
      Map<String, String> Params) async {
    return await userDetailsRemoteDataSource.updateUserData(Params);
  }

  // @override
  // Future<Either<Failures, Map<String, String>>> updateUserData(
  //     Map<String, String> Params) async {
  //   return await userDetailsRemoteDataSource.updateUserData(Params);
  // }
}
