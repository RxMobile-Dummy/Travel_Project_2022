
import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';

import '../entities/User_Enitity.dart';
import '../repositories/User_form_repository.dart';

class Registerusecase {
  final Userformrepository register_repository;

  Registerusecase({required this.register_repository});

  @override
  Stream<Either<Failures, String>> call(Map params,UserEntity user){
    return register_repository.register(params,user);
  }
}