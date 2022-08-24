import 'package:dartz/dartz.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/features/faq/domain/repositories/faq_respository.dart';
import 'package:make_my_trip_admin_panel/utils/html_editor/content_model.dart';

import '../../../../core/usecases/usecase.dart';

class FaqUseCase implements UseCase<List<ContentModel>, NoParams> {
  final FaqRepository faqRepository;
  FaqUseCase(this.faqRepository);

  @override
  Future<Either<Failures, List<ContentModel>>> call(NoParams params) async {
    return await faqRepository.getFaq();
  }
}
