import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visit_bangladesh/authentication/sign_in/email_login_page.dart';
import 'package:visit_bangladesh/authentication/sign_in/social_sign_in_button.dart';
import 'package:visit_bangladesh/common_widgets/custom_raised_button.dart';
import 'package:visit_bangladesh/common_widgets/platform_exception_alert_dialog.dart';
import 'package:visit_bangladesh/services/myUserAuth.dart';

class SignInState extends StatelessWidget {
  const SignInState({
    Key key,
    //@required this.manager,
    @required this.isLoading,
  }) : super(key: key);
  //final SignInManager manager;
  final bool isLoading;



  void _showSignInError(BuildContext context, PlatformException exception) {
    PlatformExceptionAlertDialog(
      title: 'Sign in failed',
      exception: exception,
    ).show(context);
  }

  // ignore: missing_return
  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await MyUserAuth.signInAnonymously();
    } on PlatformException catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await MyUserAuth.signInWithGoogle();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      await MyUserAuth.signInWithFacebook();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }

  void _signInWithEmail2(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => LoginPage(),
      ),
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
            height: 50,
            child: _buildHeader(),
          ),
          SizedBox(
            height: 48,
          ),

          SocialSignInButton(
            assetName: 'assets/images/google-logo.png',
            text: 'Sign in with Google',
            textColor: Colors.black54,
            color: Colors.white,
            onPressed: isLoading ? null : () => _signInWithGoogle(context),
          ),
          SizedBox(height: 9.0,),
          SocialSignInButton(
            assetName: "assets/images/facebook-logo.png",
            text: "Sign in Facebook",
            textColor: Colors.white,
            color: Color(0xFF334D92),
            onPressed: isLoading ? null : () => _signInWithFacebook(context),
          ),
          SizedBox(
            height: 9.0,
          ),
          SizedBox(
            height: 9.0,
          ),
          CustomRaisedButton(
            child: Text(
              "Sign in with email",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            color: Colors.teal[700],
            borderRadius: 16.0,
            onPressed: isLoading ? null : () => _signInWithEmail2(context),
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
            onPressed: isLoading ? null : () => _signInAnonymously(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      'Sign in',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}