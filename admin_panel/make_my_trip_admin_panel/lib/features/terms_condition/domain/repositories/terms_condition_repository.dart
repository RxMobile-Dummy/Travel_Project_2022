import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';
import '../../../../utils/html_editor/content_model.dart';

abstract class TermsConditionRepository {
  Future<Either<Failures, List<ContentModel>>> getTermsCondition();
  Future<Either<Failures, void>> updateTermsCondition(String content);
}
