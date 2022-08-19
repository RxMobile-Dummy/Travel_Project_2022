import 'package:dartz/dartz.dart';

import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/features/faq/domain/repositories/faq_respository.dart';

import '../../../../core/usecases/usecase.dart';

class FaqUpdateUseCase implements UseCase<String, FaqParams> {
  final FaqRepository faqRepository;
  FaqUpdateUseCase(this.faqRepository);

  @override
  Future<Either<Failures, String>> call(FaqParams params) async {
    return await faqRepository.updateFaq(params.title, params.content);
  }
}

class FaqParams {
  final String title;
  final String content;
  FaqParams(this.title, this.content);
}
