import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserInf {
  UserInf({@required this.uid});
  final String uid;
}
abstract class AuthBase{
  Stream<UserInf> authStateChanges();
  Future<UserInf> currentUser();
  Future<UserInf> signInAnonymously();
  Future<void> signOut();
  //Future<UserInf> initializeApp();
  Future<UserInf> signInWithGoogle();
  Future<UserInf> signInWithFacebook();
}
class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  UserInf _userFromFirebase(User user){
    if(user == null){
      return null;
    }
    return UserInf(uid: user.uid);
  }
  //@override
  Stream<UserInf> authStateChanges(){
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  @override
  Future<UserInf> currentUser() async {
    final user = await _firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }
  @override
  Future<UserInf> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<UserInf> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if(googleAccount != null){
      final googleAuth =await googleAccount.authentication;
      if(googleAuth.accessToken != null && googleAuth.idToken != null) {
        final authResult = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken
          ),
        );
        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(code: 'MISSING_GOOGLE_AUTH_TOKEN', message: 'Missing Google Auth Token,');
      }
    } else {
      throw PlatformException(code: 'ERROR_ABORTED_BY_USER', message: 'Sign in abroted by user,');
    }
  }

  Future<UserInf> signInWithFacebook() async{
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(
      ['public_profile'],
    );
    if (result.accessToken != null) {
      final authResult = await _firebaseAuth.signInWithCredential(
        FacebookAuthProvider.credential(result.accessToken.token),
      );
      return _userFromFirebase(authResult.user);
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  @override
  Future<UserInf> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await _firebaseAuth.signOut();
    final facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    await _firebaseAuth.signOut();
  }
  /*@override
  Future<UserInf> initializeApp() async {
    await Firebase.initializeApp();
  }*/
}