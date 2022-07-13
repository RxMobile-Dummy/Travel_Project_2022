
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:make_my_trip/core/failures/failures.dart';

import '../../domain/entities/User_Enitity.dart';
import '../../domain/repositories/User_form_repository.dart';
import '../data_sources/User_form_datasources.dart';
class Userrepository_impl extends Userformrepository{
  Userformdatasources userformdatasources;

  Userrepository_impl({required this.userformdatasources});



  @override
  Stream<Either<Failures, String>> register(Map param, UserEntity user) async* {
    try{

      var reponse = await userformdatasources.register(email: user.email.toString(), password: user.password.toString());
      if(reponse=="true"){
        yield Right("Successful");
      }
      else{
        yield Left(throw UnimplementedError("Not successful"));
      }

    }
    catch(e){

    }
  }




}