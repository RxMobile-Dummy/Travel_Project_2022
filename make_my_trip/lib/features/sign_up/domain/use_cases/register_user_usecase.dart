
import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import '../repositories/register_user_repository.dart';

class Register_User_Usecase {
  final Register_User_Repository register_user_repository;

  Register_User_Usecase({required this.register_user_repository});

  @override
  Future<Either<Failures, dynamic>> call(Map params,String email,String password){
    return register_user_repository.register_user(params,email,password);
  }
}