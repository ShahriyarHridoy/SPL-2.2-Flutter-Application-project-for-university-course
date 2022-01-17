import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:visit_bangladesh/services/auth.dart';
import 'package:visit_bangladesh/services/myUserAuth.dart';


class SignInManager {
  //SignInManager({@required this.auth, @required this.isLoading});
  //final AuthBase auth;
  
   ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<User> _signIn(Future<User> Function() signInMethod) async {
    try {
      isLoading.value = true;
      return await signInMethod();
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  Future<User> signInAnonymously() async => await _signIn(MyUserAuth.signInAnonymously);

  Future<User> signInWithGoogle() async => await _signIn(MyUserAuth.signInWithGoogle);

  Future<User> signInWithFacebook() async => await _signIn(MyUserAuth.signInWithFacebook);
}
