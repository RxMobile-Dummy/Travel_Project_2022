import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/user_history/data/data_sources/user_history_remote_data_source.dart';
import 'package:make_my_trip/features/user_history/domain/repositories/user_history_repository.dart';

import '../model/user_history_model.dart';

class UserHistoryRepositoryImpl implements UserHistoryRepository {
  final UserHistoryDataSource userHistoryDataSource;

  UserHistoryRepositoryImpl(this.userHistoryDataSource);

  @override
  Future<Either<Failures, List<UserHistoryModel>>> getUserHistory(page) async {
    return await userHistoryDataSource.getUserHistoryData(page);
  }
}
