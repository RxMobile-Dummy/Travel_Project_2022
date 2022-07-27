import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/core/usecases/usecases.dart';
import 'package:make_my_trip/features/setting_page/domain/repositories/setting_page_repository.dart';

class UpdateUserDataUseCase implements UseCase<void, Map<String, String>> {
  Settingpagerepository settingpagerepository;

  UpdateUserDataUseCase(this.settingpagerepository);

  @override
  Future<Either<Failures, void>> call(Map<String, String> params) async {
    return await settingpagerepository.updateUserData(params);
  }
}
