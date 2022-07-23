import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/core/usecases/usecases.dart';
import 'package:make_my_trip/features/login/domain/model/user_model.dart';
import 'package:make_my_trip/features/setting_page/data/models/user_details_model.dart';
import 'package:make_my_trip/features/setting_page/domain/repositories/setting_page_repository.dart';

class GetUserDataUseCase implements UseCase<UserDetailsModel, NoParams> {
  Settingpagerepository settingpagerepository;
  GetUserDataUseCase(this.settingpagerepository);

  @override
  Future<Either<Failures, UserDetailsModel>> call(NoParams params) async {
    print("myusecase");
    return await settingpagerepository.getUserData();
  }
}
