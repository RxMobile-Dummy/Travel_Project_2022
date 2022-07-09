import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void changeObSecureEvent(bool obSecure) {
    emit(ChangeState(!obSecure));
  }
  googlesignin() async{

    final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: ['email'],
    );
    final FirebaseAuth _auth = FirebaseAuth.instance;

    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final User? user = (await _auth.signInWithCredential(credential)).user;
    // final usercollectionref = firestore.collection("User data");
    // //   final uid = await getcurrentUid();
    // final uid  = FirebaseAuth.instance.currentUser?.uid;
    // usercollectionref.doc(uid).get().then((value){
    //   //  writeData();
    //   var mapdata = {
    //     "email":user?.email,
    //     "name":user?.displayName,
    //     "profile picture":user?.photoURL,
    //     "user id":user?.uid,
    //     "phonenumber":user?.phoneNumber
    //   };
    //   usercollectionref.doc(uid).set(mapdata).then((value){
    //
    //   });


    //});
    return user;
  }

  Future<String?> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider
          .credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      await _auth.signInWithCredential(facebookAuthCredential);
      emit(FaceBookSuccessState());
    } on FirebaseAuthException catch (e) {
      print(e.message);
      emit(FaceBookFailureState());
      throw e;
    }
  }

}
