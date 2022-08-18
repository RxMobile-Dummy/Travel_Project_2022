import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';
import '../../../../utils/html_editor/content_model.dart';

abstract class PrivacyPolicyRepository {
  Future<Either<Failures, List<ContentModel>>> getPrivacyPolicy();
  Future<Either<Failures, String>> updatePrivacyPolicy(String content);
}
