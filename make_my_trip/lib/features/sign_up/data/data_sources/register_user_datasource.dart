
import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';

abstract class Register_User_Datasource{

 Future<Either<Failures, dynamic>> register_user({required String email, required String password});
}