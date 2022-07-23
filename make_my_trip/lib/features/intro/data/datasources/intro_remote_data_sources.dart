import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/failures/failures.dart';

abstract class IntroRemoteDataSource {
  Future<Either<Failures, bool>> logInAnonymously();
}

class IntroRemoteDataSourceImpl extends IntroRemoteDataSource {
  final FirebaseAuth auth;
  final SharedPreferences sharedPreferences;

  IntroRemoteDataSourceImpl(
      {required this.auth, required this.sharedPreferences});

  @override
  Future<Either<Failures, bool>> logInAnonymously() async {
    final userId = sharedPreferences.getString("userId");

    try {
      if (userId == null || userId == "") {
        UserCredential userCredential = await auth.signInAnonymously();
        User? user = userCredential.user;

        sharedPreferences.setString("userId", user!.uid);
      }
      return const Right(true);
    } catch (err) {
      return Left(ServerFailure());
    }
  }
}
