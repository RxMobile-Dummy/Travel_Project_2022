import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';
import '../../../../utils/html_editor/content_model.dart';

abstract class AboutUsRepository {
  Future<Either<Failures, List<ContentModel>>> getAboutUs();
  Future<Either<Failures, void>> updateAboutUs(String content);
}
