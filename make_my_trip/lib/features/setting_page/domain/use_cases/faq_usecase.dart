import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/setting_page/data/models/faq_model.dart';

import '../../../../core/usecases/usecase.dart';
import '../repositories/setting_page_repository.dart';

class FaqUseCase implements Usecase<List<FaqModel>, NoParams> {
  final SettingPageRepository settingPageRepository;
  FaqUseCase(this.settingPageRepository);

  @override
  Future<Either<Failures, List<FaqModel>>> call(NoParams params) async {
    return await settingPageRepository.getFaq();
  }
}

