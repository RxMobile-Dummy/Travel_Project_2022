///use this class for handling failures of whole app
abstract class Failures {}

class ServerFailure extends Failures {
  String? failureMsg;
  String? statusCode;
  ServerFailure({this.failureMsg,this.statusCode});
}

class InternetFailure extends Failures {
  String? failureMsg;

  InternetFailure({this.failureMsg});
}

class AuthFailure extends Failures {
  String? failureMsg;

  AuthFailure({this.failureMsg});
}

class ErrorWithMessageFailure extends Failures {
  String failureMsg;

  ErrorWithMessageFailure(this.failureMsg);
}
