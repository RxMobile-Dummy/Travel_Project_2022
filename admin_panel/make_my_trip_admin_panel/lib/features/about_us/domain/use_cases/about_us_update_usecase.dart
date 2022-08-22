import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../utils/html_editor/content_model.dart';
import '../repositories/about_us_repository.dart';

class AboutUsUpdateUseCase implements UseCase<void, UpdateParams> {
  final AboutUsRepository aboutUsRepository;
  AboutUsUpdateUseCase(this.aboutUsRepository);

  @override
  Future<Either<Failures, void>> call(UpdateParams params) async {
    return await aboutUsRepository.updateAboutUs(params.data);
  }
}

class UpdateParams {
  final String data;
  UpdateParams(this.data);
}
