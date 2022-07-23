import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/login/domain/model/user_model.dart';
import 'package:make_my_trip/features/setting_page/data/data_sources/user_details_remote_data_source.dart';
import 'package:make_my_trip/features/setting_page/data/models/user_details_model.dart';
import 'package:make_my_trip/features/setting_page/domain/repositories/setting_page_repository.dart';

class Settingpagerepositoryimpl implements Settingpagerepository {
  UserDetailsRemoteDataSource userDetailsRemoteDataSource;
  Settingpagerepositoryimpl(this.userDetailsRemoteDataSource);
  @override
  Future<Either<Failures, UserDetailsModel>> getUserData() async {
    return await userDetailsRemoteDataSource.getUserData();
  }
}
