import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:make_my_trip/features/login/domain/model/user_model.dart';

import '../../../../core/failures/failures.dart';

abstract class UserRemoteDataSource {
  Future<Either<Failures, bool>> isAnonumousUser();
  Future<Either<Failures, UserModel>> getUser();
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  final FirebaseAuth auth;

  UserRemoteDataSourceImpl({required this.auth});

  @override
  Future<Either<Failures, bool>> isAnonumousUser() async {
    try {
      User? user = auth.currentUser;
      if (user?.email != null) {
        return Right(false);
      } else {
        return Right(true);
      }
    } catch (err) {
      print(err);
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, UserModel>> getUser() async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        return Right(UserModel(
            userName: user.displayName,
            userEmail: user.email,
            userPhone: user.phoneNumber,
            userPic: user.photoURL,
            userId: user.uid));
      } else {
        return Right(UserModel.fromJson({}));
      }
    } catch (err) {
      return Left(ServerFailure(failureMsg: "Something went wrong"));
    }
  }
}
