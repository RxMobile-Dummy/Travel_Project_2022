
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/User_Enitity.dart';
import 'User_form_datasources.dart';
class Userformdatasourcesimpl extends Userformdatasources {
  final FirebaseAuth? auth;

  late bool istrue = false;

  Userformdatasourcesimpl({this.auth});


  @override
  Future<String> register({required String email, required String password}) async{
   UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email:email.toString().trim(), password: password.toString().trim()).catchError((errror){
     print(errror);
   });
   if (user.user?.email != null) {
     return "true";
   }
   else {

     return "false";
   }
  }

 

}


