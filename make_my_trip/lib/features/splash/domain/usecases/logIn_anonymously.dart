import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/splash/domain/repositories/splash_repository.dart';

class LogInAnonymously extends Usecase<bool, NoParams> {
  final SplashRepository repository;

  LogInAnonymously({required this.repository});

  @override
  Future<Either<Failures, bool>> call(NoParams params) async {
    return await repository.logInAnonymously();
  }
}
