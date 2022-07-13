
import 'package:firebase_auth/firebase_auth.dart';
import 'register_user_datasource.dart';
class Register_User_Datasource_Impl extends Register_User_Datasource {

  late bool istrue = false;

  @override
  Future<String> register_user({required String email, required String password}) async{
   UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email:email.toString().trim(), password: password.toString().trim());
   if (user.user?.email != null) {
     return "true";
   }
   else {

     return "false";
   }
  }

 

}


