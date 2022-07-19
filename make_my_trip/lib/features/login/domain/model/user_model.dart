import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? userName, userEmail, userPhone, userPic, userId;

  const UserModel(
      {required this.userName,
      required this.userEmail,
      required this.userPhone,
      required this.userPic,
      required this.userId});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        userEmail: json['userEmail'],
        userId: json['userId'],
        userName: json['userName'],
        userPhone: json['userPhone'],
        userPic: json['userPic']);
  }

  Map<String, dynamic> toJson() {
    return {
      "userName": userName,
      "userEmail": userEmail,
      "userId": userId,
      "userPhone": userPhone,
      "userPic": userPic
    };
  }

  @override
  List<Object?> get props => [userName, userEmail, userPhone, userPic, userId];
}
