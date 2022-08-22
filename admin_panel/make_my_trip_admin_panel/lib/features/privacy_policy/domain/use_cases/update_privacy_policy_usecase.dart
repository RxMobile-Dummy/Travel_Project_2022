import 'package:dartz/dartz.dart';

import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/features/privacy_policy/domain/repositories/privacy_policy_repository.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../about_us/domain/use_cases/about_us_update_usecase.dart';

class PrivacyPolicyUpdateUseCase implements UseCase<void, UpdateParams> {
  final PrivacyPolicyRepository privacyPolicyRepository;
  PrivacyPolicyUpdateUseCase(this.privacyPolicyRepository);

  @override
  Future<Either<Failures, void>> call(UpdateParams params) async {
    return await privacyPolicyRepository.updatePrivacyPolicy(params.data);
  }
}
