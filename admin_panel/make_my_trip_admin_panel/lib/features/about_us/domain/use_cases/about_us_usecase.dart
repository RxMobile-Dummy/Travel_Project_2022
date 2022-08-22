import 'package:dartz/dartz.dart';
import 'package:make_my_trip_admin_panel/features/about_us/domain/repositories/about_us_repository.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../utils/html_editor/content_model.dart';

class AboutUsUseCase implements UseCase<List<ContentModel>, NoParams> {
  final AboutUsRepository aboutUsRepository;
  AboutUsUseCase(this.aboutUsRepository);

  @override
  Future<Either<Failures, List<ContentModel>>> call(NoParams params) async {
    return await aboutUsRepository.getAboutUs();
  }
}
