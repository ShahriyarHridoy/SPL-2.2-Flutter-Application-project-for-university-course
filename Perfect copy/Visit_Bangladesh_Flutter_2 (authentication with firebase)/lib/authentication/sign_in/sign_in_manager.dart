import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:visit_bangladesh/services/auth.dart';


class SignInManager {
  SignInManager({@required this.auth, @required this.isLoading});
  final AuthBase auth;
  final ValueNotifier<bool> isLoading;

  Future<UserInf> _signIn(Future<UserInf> Function() signInMethod) async {
    try {
      isLoading.value = true;
      return await signInMethod();
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  Future<UserInf> signInAnonymously() async => await _signIn(auth.signInAnonymously);

  Future<UserInf> signInWithGoogle() async => await _signIn(auth.signInWithGoogle);

  Future<UserInf> signInWithFacebook() async => await _signIn(auth.signInWithFacebook);
}
