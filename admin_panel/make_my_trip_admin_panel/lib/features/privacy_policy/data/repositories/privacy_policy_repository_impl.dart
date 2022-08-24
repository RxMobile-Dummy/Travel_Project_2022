import 'package:dartz/dartz.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/features/privacy_policy/data/data_sources/privacy_policy_remote_data_sources.dart';
import 'package:make_my_trip_admin_panel/features/privacy_policy/domain/repositories/privacy_policy_repository.dart';
import 'package:make_my_trip_admin_panel/utils/html_editor/content_model.dart';

class PrivacyPolicyRepositoryImpl extends PrivacyPolicyRepository {
  final PrivacyPolicyRemoteDataSources privacyPolicyRemoteDataSources;
  PrivacyPolicyRepositoryImpl(this.privacyPolicyRemoteDataSources);

  @override
  Future<Either<Failures, List<ContentModel>>> getPrivacyPolicy() async {
    return await privacyPolicyRemoteDataSources.getPrivacyPolicyData();
  }

  @override
  Future<Either<Failures, void>> updatePrivacyPolicy(String content) async {
    return await privacyPolicyRemoteDataSources
        .updatePrivacyPolicyData(content);
  }
}
