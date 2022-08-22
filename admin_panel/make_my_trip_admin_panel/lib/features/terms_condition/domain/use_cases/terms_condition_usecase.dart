import 'package:dartz/dartz.dart';

import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/features/terms_condition/domain/repositories/terms_condition_repository.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../utils/html_editor/content_model.dart';

class TermsConditionUseCase implements UseCase<List<ContentModel>, NoParams> {
  final TermsConditionRepository termsConditionRepository;
  TermsConditionUseCase(this.termsConditionRepository);

  @override
  Future<Either<Failures, List<ContentModel>>> call(NoParams params) async {
    return await termsConditionRepository.getTermsCondition();
  }
}
