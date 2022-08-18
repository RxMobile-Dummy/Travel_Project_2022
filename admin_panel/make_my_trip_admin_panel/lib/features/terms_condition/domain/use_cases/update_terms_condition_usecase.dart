import 'package:dartz/dartz.dart';

import 'package:make_my_trip_admin_panel/core/failures/failures.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../utils/html_editor/content_model.dart';
import '../../../about_us/domain/use_cases/about_us_update_usecase.dart';
import '../repositories/terms_condition_repository.dart';

class TermsConditionUpdateUseCase implements UseCase<String, UpdateParams> {
  final TermsConditionRepository termsConditionRepository;
  TermsConditionUpdateUseCase(this.termsConditionRepository);

  @override
  Future<Either<Failures, String>> call(UpdateParams params) async {
    return await termsConditionRepository.updateTermsCondition(params.data);
  }
}
