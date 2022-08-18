import 'package:dartz/dartz.dart';
import 'package:make_my_trip_admin_panel/utils/html_editor/content_model.dart';

import '../../../../core/failures/failures.dart';

abstract class FaqRepository {
  Future<Either<Failures, List<ContentModel>>> getFaq();
  Future<Either<Failures, String>> updateFaq(String title, String content);
}
