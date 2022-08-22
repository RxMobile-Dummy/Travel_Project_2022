import 'package:dartz/dartz.dart';

import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/setting_page/data/models/content_model.dart';

import '../../../../core/usecases/usecase.dart';
import '../../data/models/faq_model.dart';
import '../repositories/setting_page_repository.dart';

class AboutUsUseCase implements Usecase<List<ContentModel>, NoParams> {
  final SettingPageRepository settingPageRepository;
  AboutUsUseCase(this.settingPageRepository);

  @override
  Future<Either<Failures, List<ContentModel>>> call(NoParams params) async {
    return await settingPageRepository.getAboutUs();
  }
}
