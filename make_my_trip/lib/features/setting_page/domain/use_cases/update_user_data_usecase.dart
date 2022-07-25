import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/core/usecases/usecases.dart';
import 'package:make_my_trip/features/room_detail_page/domain/use_cases/room_detail_usecase.dart';
import 'package:make_my_trip/features/setting_page/data/models/user_details_model.dart';
import 'package:make_my_trip/features/setting_page/domain/repositories/setting_page_repository.dart';

class UpdateUserDataUseCase implements UseCase<void, Map<String, String>> {
  Settingpagerepository settingpagerepository;
  UpdateUserDataUseCase(this.settingpagerepository);

  @override
  Future<Either<Failures, void>> call(Map<String, String> params) async {
    return await settingpagerepository.updateUserData(params);
  }

  // @override
  // Future<Either<Failures,Map<String, String>>> call(Map<String, String> Params) async {
  //   print("myusecase");
  //   return await settingpagerepository.updateUserData(Params);
  // }
}

//'UpdateUserDataUseCase.call' ('Future<Either<Failures, Map<String, String>>> Function(Map<String, String>)') isn't a valid override of 'UseCase.call' ('Future<Either<Failures, Map<String, String>>> Function(Params)').