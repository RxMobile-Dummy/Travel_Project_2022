import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:make_my_trip/core/failures/failures.dart';

import '../entities/User_Enitity.dart';


abstract class Userformrepository{

  Stream<Either<Failures, String>> register(Map param, UserEntity user);


}