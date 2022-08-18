import 'package:dartz/dartz.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/features/terms_condition/data/data_sources/terms_condition_remote_data_sources.dart';
import 'package:make_my_trip_admin_panel/features/terms_condition/domain/repositories/terms_condition_repository.dart';
import 'package:make_my_trip_admin_panel/utils/html_editor/content_model.dart';

class TermsConditionRepositoryImpl extends TermsConditionRepository {
  final TermsConditionRemoteDataSources termsConditionRemoteDataSources;
  TermsConditionRepositoryImpl(this.termsConditionRemoteDataSources);

  @override
  Future<Either<Failures, List<ContentModel>>> getTermsCondition() async {
    return await termsConditionRemoteDataSources.getTermsConditionData();
  }

  @override
  Future<Either<Failures, String>> updateTermsCondition(String content) async {
    return await termsConditionRemoteDataSources
        .updateTermsConditionData(content);
  }
}
