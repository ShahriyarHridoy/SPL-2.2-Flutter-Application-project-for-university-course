import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visit_bangladesh/authentication/sign_in/social_sign_in_button.dart';
import 'package:visit_bangladesh/common_widgets/custom_raised_button.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:visit_bangladesh/services/auth.dart';

class SignInState extends StatelessWidget {
  SignInState({@required this.auth});

  //final Function(UserInf) onSignIn;
  final AuthBase auth;

  // ignore: missing_return
  Future<Void> _signInAnonymously() async {
    //await Firebase.initializeApp();
    try {
      await auth.signInAnonymously();
      //print('${authResult.user.uid}');
      //onSignIn(user);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Void> _signInWithGoogle() async {
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Void> _signInWithFacebook() async {
    try {
      await auth.signInWithFacebook();
    } catch (e) {
      print(e.toString());
    }
  }

  void _signInWithEmail(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        //builder: (context) => EmailSignInPage(),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Visit Bangladesh"),
        backgroundColor: Colors.blue,
        elevation: 20.0,
      ),
      body: _buildContent(context),
      backgroundColor: Colors.yellow[300],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      //color: Colors.yellow,
      padding: EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Text(
            "Sign In",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          SizedBox(
            height: 60,
          ),
          /* CustomRaisedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/images/google-logo.png"),
                Text("Sign in with Google", style: TextStyle(color: Colors.black54, fontSize: 18,),),
                Opacity(opacity: 0.0, child: Image.asset("assets/images/google-logo.png"),)
              ],
            ),
            color: Colors.white,
            borderRadius: 16.0,
            onPressed: () {},
          ),
          SizedBox(
            height: 9,
          ),
          CustomRaisedButton(
            child: Text(
              "Sign in Google",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            color: Colors.deepOrange[400],
            borderRadius: 16.0,
            onPressed: () {
              print("button pressed");
            },
          ),
          SizedBox(
            height: 9.0,
          ),*/
          SocialSignInButton(
            assetName: 'assets/images/google-logo.png',
            text: 'Sign in with Google',
            textColor: Colors.black54,
            color: Colors.white,
            onPressed: _signInWithGoogle,
          ),
          SizedBox(height: 9.0,),
          SocialSignInButton(
            assetName: "assets/images/facebook-logo.png",
            text: "Sign in Facebook",
            textColor: Colors.white,
            color: Color(0xFF334D92),
            onPressed: _signInWithFacebook,
          ),
          SizedBox(
            height: 9.0,
          ),
          CustomRaisedButton(
            child: Text(
              "Sign in email",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            color: Colors.teal[700],
            borderRadius: 16.0,
            //onPressed: _signInWithEmail(context),
          ),
          SizedBox(
            height: 9.0,
          ),
          Text(
            "or",
            style: TextStyle(
                color: Colors.redAccent,
                fontSize: 25,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 9.0,
          ),
          CustomRaisedButton(
            child: Text(
              "Go anonymous",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            color: Colors.blueGrey,
            borderRadius: 16.0,
            onPressed: _signInAnonymously,
          ),
        ],
      ),
    );
  }
}