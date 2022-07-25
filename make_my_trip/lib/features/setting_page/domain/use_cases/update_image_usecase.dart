import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/core/usecases/usecases.dart';
import 'package:make_my_trip/features/setting_page/data/models/user_details_model.dart';
import 'package:make_my_trip/features/setting_page/domain/repositories/setting_page_repository.dart';

class UpdateImageUseCase implements UseCase<String, NoParams> {
  Settingpagerepository settingpagerepository;
  UpdateImageUseCase(this.settingpagerepository);

  @override
  Future<Either<Failures, String>> call(NoParams params) async {
    return await settingpagerepository.updateImagefromGallery();
  }

  Future<Either<Failures, String>> callImagefromCamera(NoParams params) async {
    return await settingpagerepository.updateImagefromCamera();
  }
}
