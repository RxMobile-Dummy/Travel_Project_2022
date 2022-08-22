import 'package:dartz/dartz.dart';

import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/features/privacy_policy/domain/repositories/privacy_policy_repository.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../utils/html_editor/content_model.dart';

class PrivacyPolicyUseCase implements UseCase<List<ContentModel>, NoParams> {
  final PrivacyPolicyRepository privacyPolicyRepository;
  PrivacyPolicyUseCase(this.privacyPolicyRepository);

  @override
  Future<Either<Failures, List<ContentModel>>> call(NoParams params) {
    return privacyPolicyRepository.getPrivacyPolicy();
  }
}
