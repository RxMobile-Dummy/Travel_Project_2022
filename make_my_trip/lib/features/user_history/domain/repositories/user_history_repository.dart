import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/user_history/data/model/user_history_model.dart';

abstract class UserHistoryRepository {
  Future<Either<Failures , List<UserHistoryModel>>> getUserHistory();
}