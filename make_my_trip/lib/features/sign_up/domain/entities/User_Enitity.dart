import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{
  final String? email;
  final String? password;



  UserEntity({this.email,this.password});


    @override
  // TODO: implement props
  List<Object?> get props => [email,password];

}