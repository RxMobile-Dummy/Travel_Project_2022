import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/setting_page/domain/repositories/setting_page_repository.dart';

class UpdateImageUseCase implements Usecase<String, NoParams> {
  SettingPageRepository settingPageRepository;

  UpdateImageUseCase(this.settingPageRepository);

  @override
  Future<Either<Failures, String>> call(NoParams params) async {
    return await settingPageRepository.updateImageFromGallery();
  }

  Future<Either<Failures, String>> callImageFromCamera(NoParams params) async {
    return await settingPageRepository.updateImageFromCamera();
  }
}
