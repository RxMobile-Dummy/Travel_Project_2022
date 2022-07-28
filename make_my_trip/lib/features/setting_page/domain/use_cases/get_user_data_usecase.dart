import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/setting_page/data/models/user_details_model.dart';
import 'package:make_my_trip/features/setting_page/domain/repositories/setting_page_repository.dart';

class GetUserDataUseCase implements Usecase<UserDetailsModel, NoParams> {
  SettingPageRepository settingPageRepository;

  GetUserDataUseCase(this.settingPageRepository);

  @override
  Future<Either<Failures, UserDetailsModel>> call(NoParams params) async {
    return await settingPageRepository.getUserData();
  }
}
