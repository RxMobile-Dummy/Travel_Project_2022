import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/user_history/data/model/user_history_model.dart';
import 'package:make_my_trip/features/user_history/domain/repositories/user_history_repository.dart';

class UserHistoryUsecase implements Usecase<List<UserHistoryModel>, NoParams> {
 final UserHistoryRepository userHistoryRepository;

  UserHistoryUsecase(this.userHistoryRepository);

  @override
  Future<Either<Failures, List<UserHistoryModel>>> call(NoParams params) async{

    return await userHistoryRepository.getUserHistory();
  }
}
