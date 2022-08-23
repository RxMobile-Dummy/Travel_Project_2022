import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/content_model.dart';
import '../repositories/setting_page_repository.dart';

class PrivacyPolicyUseCase implements Usecase<List<ContentModel>, NoParams> {
  final SettingPageRepository settingPageRepository;
  PrivacyPolicyUseCase(this.settingPageRepository);

  @override
  Future<Either<Failures, List<ContentModel>>> call(NoParams params) async {
    return await settingPageRepository.getPrivacyPolicy();
  }
}
