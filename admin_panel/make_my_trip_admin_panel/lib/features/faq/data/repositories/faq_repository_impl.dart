import 'package:dartz/dartz.dart';

import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/features/faq/data/data_sources/faq_remote_data_sources.dart';
import 'package:make_my_trip_admin_panel/utils/html_editor/content_model.dart';

import '../../domain/repositories/faq_respository.dart';

class FaqRepositoryImpl extends FaqRepository {
  final FaqRemoteDataSources faqRemoteDataSources;
  FaqRepositoryImpl(this.faqRemoteDataSources);

  @override
  Future<Either<Failures, List<ContentModel>>> getFaq() async {
    return await faqRemoteDataSources.getFaqData();
  }

  @override
  Future<Either<Failures, void>> updateFaq(String title, String content) async {
    return await faqRemoteDataSources.updateFaqData(title, content);
  }
}
