import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../bloc.navigation_bloc/navigation_bloc.dart';

// ignore: must_be_immutable
class LogoutPage extends StatelessWidget with NavigationStates {
  int val=1;
  LogoutPage({@required this.onSignOut});
  final VoidCallback onSignOut;

  Future<Void> _signOut() async{
    //await Firebase.initializeApp();
    try{
      await FirebaseAuth.instance.signOut();
      onSignOut();
      //print('${authResult.user.uid}');
    } catch(e) {
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    if(onSignOut == null){
      _signOut();
    }
    /*return Center(
      child: Text(
        "Log Out",
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
      ),
    );*/
  }
}