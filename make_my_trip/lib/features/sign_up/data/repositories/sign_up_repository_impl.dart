// import 'package:dartz/dartz.dart';
// import 'package:make_my_trip/core/failures/failures.dart';
// import '../../domain/repositories/sign_up_repository.dart';
// import '../data_sources/sign_up_remote_datasource_impl.dart';
//
// class SignUpRepositoryImpl extends SignUpRepository {
//   SignUpRemoteDataSource remoteDataSource;
//
//   SignUpRepositoryImpl({required this.remoteDataSource});
//
//   @override
//   Future<Either<Failures, bool>> userSignUp(
//       String fullName, String email, String password) async {
//     return await remoteDataSource.userSignUp(
//         fullName: fullName,
//         email: email.toString(),
//         password: password.toString());
//   }
//
//   @override
//   Future<Either<Failures, bool>> userVerification() async {
//     return await remoteDataSource.userVerification();
//   }
// }
