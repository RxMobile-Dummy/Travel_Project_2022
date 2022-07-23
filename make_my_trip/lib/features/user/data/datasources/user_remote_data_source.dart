import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/failures/failures.dart';

abstract class UserRemoteDataSource {
  Future<Either<Failures, bool>> isAnonumousUser();
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  final FirebaseAuth auth;

  UserRemoteDataSourceImpl({required this.auth});

  @override
  Future<Either<Failures, bool>> isAnonumousUser() async {
    try {
      User? user = auth.currentUser;
      if (user!.email != null) {
        return Right(false);
      } else {
        return Right(true);
      }
    } catch (err) {
      return Left(ServerFailure());
    }
  }
}
