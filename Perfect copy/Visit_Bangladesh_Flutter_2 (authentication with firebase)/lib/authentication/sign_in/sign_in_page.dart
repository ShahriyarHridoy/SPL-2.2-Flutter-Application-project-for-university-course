import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:visit_bangladesh/authentication/sign_in/email_sign_in_page.dart';
import 'package:visit_bangladesh/authentication/sign_in/sign_in_manager.dart';
import 'package:visit_bangladesh/authentication/sign_in/social_sign_in_button.dart';
import 'package:visit_bangladesh/common_widgets/custom_raised_button.dart';
import 'package:visit_bangladesh/common_widgets/platform_exception_alert_dialog.dart';
import 'package:visit_bangladesh/services/auth.dart';

class SignInState extends StatelessWidget {
  const SignInState({
    Key key,
    @required this.manager,
    @required this.isLoading,
  }) : super(key: key);
  final SignInManager manager;
  final bool isLoading;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoading, __) => Provider<SignInManager>(
          create: (_) => SignInManager(auth: auth, isLoading: isLoading),
          child: Consumer<SignInManager>(
            builder: (context, manager, _) => SignInState(
              manager: manager,
              isLoading: isLoading.value,
            ),
          ),
        ),
      ),
    );
  }

  void _showSignInError(BuildContext context, PlatformException exception) {
    PlatformExceptionAlertDialog(
      title: 'Sign in failed',
      exception: exception,
    ).show(context);
  }

  // ignore: missing_return
  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await manager.signInAnonymously();
    } on PlatformException catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await manager.signInWithGoogle();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      await manager.signInWithFacebook();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(),
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
          /*Text(
            "Sign In",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),*/
          SizedBox(
            height: 48,
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
            onPressed: isLoading ? null : () => _signInWithEmail(context),
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