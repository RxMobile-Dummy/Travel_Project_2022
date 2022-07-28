import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/setting_page/domain/repositories/setting_page_repository.dart';

class UpdateUserDataUseCase implements Usecase<void, Map<String, String>> {
  SettingPageRepository settingPageRepository;

  UpdateUserDataUseCase(this.settingPageRepository);

  @override
  Future<Either<Failures, void>> call(Map<String, String> params) async {
    return await settingPageRepository.updateUserData(params);
  }
}
