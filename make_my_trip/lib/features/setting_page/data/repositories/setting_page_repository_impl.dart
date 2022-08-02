import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/setting_page/data/data_sources/user_details_remote_data_source.dart';
import 'package:make_my_trip/features/setting_page/data/models/user_details_model.dart';
import 'package:make_my_trip/features/setting_page/domain/repositories/setting_page_repository.dart';

class SettingPageRepositoryImpl implements SettingPageRepository {
  UserDetailsRemoteDataSource userDetailsRemoteDataSource;

  SettingPageRepositoryImpl(this.userDetailsRemoteDataSource);

  @override
  Future<Either<Failures, UserDetailsModel>> getUserData() async {
    return await userDetailsRemoteDataSource.getUserData();
  }

  @override
  Future<Either<Failures, String>> updateImageFromGallery() async {
    return await userDetailsRemoteDataSource.updateImageFromGallery();
  }

  @override
  Future<Either<Failures, String>> updateImageFromCamera() async {
    return await userDetailsRemoteDataSource.updateImageFromCamera();
  }

  @override
  Future<Either<Failures, void>> updateUserData(
      Map<String, String> params) async {
    return await userDetailsRemoteDataSource.updateUserData(params);
  }
}
