import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/failures/failures.dart';

abstract class SplashRemoteDataSource {
  Future<Either<Failures, bool>> logInAnonymously();
}

class SplashRemoteDataSourceImpl extends SplashRemoteDataSource {
  final FirebaseAuth auth;

  SplashRemoteDataSourceImpl({required this.auth});

  @override
  Future<Either<Failures, bool>> logInAnonymously() async {
    try {
      if (auth.currentUser == null) {
        UserCredential userCredential = await auth.signInAnonymously();
        User? user = userCredential.user;
        return const Right(true);
      } else {
        return const Right(true);
      }
    } catch (err) {
      return Left(ServerFailure());
    }
  }
}
