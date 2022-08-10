import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/user_history/domain/repositories/user_history_repository.dart';

class UserHistoryUsecase implements Usecase<List<UserHistoryModel>, int> {
 final UserHistoryRepository userHistoryRepository;

 UserHistoryUsecase(this.userHistoryRepository);

 @override
 Future<Either<Failures, List<UserHistoryModel>>> call(int page) async{

  return await userHistoryRepository.getUserHistory(page);
 }
}