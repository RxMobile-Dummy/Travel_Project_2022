import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:make_my_trip/core/failures/failures.dart';


abstract class Register_User_Repository{

  Future<Either<Failures,dynamic>> register_user(Map param,String email,String password);


}