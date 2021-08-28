import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visit_bangladesh/all_side_bar/sidebar/sidebar.dart';
import 'package:visit_bangladesh/authentication/components/form_input_field_with_icon.dart';
import 'package:visit_bangladesh/authentication/components/form_vertical_spacing.dart';
import 'package:visit_bangladesh/authentication/components/label_button.dart';
import 'package:visit_bangladesh/authentication/components/loading_screen.dart';
import 'package:visit_bangladesh/authentication/components/logo_graphic_header.dart';
import 'package:visit_bangladesh/authentication/components/primary_button.dart';
import 'package:visit_bangladesh/authentication/landing_page.dart';
import 'package:visit_bangladesh/authentication/sign_in/email_register_page.dart';
import 'package:visit_bangladesh/authentication/sign_in/validators.dart';
import 'package:visit_bangladesh/services/auth.dart';
import 'package:visit_bangladesh/services/myUserAuth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  String get _email => _emailTextController.text;
  String get _password => _passwordTextController.text;

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;
  bool _loading = false;

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User user = await MyUserAuth.currentUser();

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LandingPage(),
        ),
      );
    }

    return firebaseApp;
  }

  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      body: LoadingScreen(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    LogoGraphicHeader(),
                    SizedBox(height: 48.0),
                    FormInputFieldWithIcon(
                      controller: _emailTextController,
                      iconPrefix: Icons.email,
                      labelText: "email",
                      validator:(value) => Validator.validateEmail(
                          email: value,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => null,
                      onSaved: (value) =>  _emailTextController.text = value,
                    ),
                    FormVerticalSpace(),
                    FormInputFieldWithIcon(
                      controller: _passwordTextController,
                      iconPrefix: Icons.lock,
                      labelText: "password",
                      validator: (value) => Validator.validatePassword(
                        password: value,
                      ),
                      obscureText: true,
                      onChanged: (value) => null,
                      onSaved: (value) => _passwordTextController.text = value,
                      maxLines: 1,
                    ),
                    FormVerticalSpace(),
                    PrimaryButton(
                        labelText: "Sign IN",
                        onPressed: () async {
                          print('Press Sign in Button');
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              _loading = true;
                            });
                            //AuthService _auth = AuthService();
                            print(' getting user');
                            User user = await MyUserAuth.signInWithEmailAndPassword(_email, _password );
                            print('user get it $user');

                              setState(() {
                                _loading = false;
                              });


                            if (user != null) {
                              Navigator.of(context)
                                  .pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => LandingPage(),
                                ),
                              );
                            }
                          }
                        }),
                    FormVerticalSpace(),
                    LabelButton(
                      labelText: "Reset Password",
                      onPressed: () => Navigator.pushReplacementNamed(
                          context, '/reset-password'),
                    ),
                    LabelButton(
                      labelText: "Sign UP",
                      onPressed: () =>
                          //Navigator.pushReplacementNamed(context, '/signup'),
                      Navigator.of(context)
                          .pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(),
                        ),
                      )
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        inAsyncCall: _loading,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }



  /*@override
  Widget build(BuildContext context) {
    //final AuthBase auth = Provider.of<AuthBase>(context);
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Firebase Authentication'),
        ),
        body: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Text(
                        'Login',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _emailTextController,
                            focusNode: _focusEmail,
                            validator: (value) => Validator.validateEmail(
                              email: value,
                            ),
                            decoration: InputDecoration(
                              hintText: "Email",
                              errorBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0),
                          TextFormField(
                            controller: _passwordTextController,
                            focusNode: _focusPassword,
                            obscureText: true,
                            validator: (value) => Validator.validatePassword(
                              password: value,
                            ),
                            decoration: InputDecoration(
                              hintText: "Password",
                              errorBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 24.0),
                          _isProcessing
                              ? CircularProgressIndicator()
                              : Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    _focusEmail.unfocus();
                                    _focusPassword.unfocus();

                                    if (_formKey.currentState
                                        .validate()) {
                                      setState(() {
                                        _isProcessing = true;
                                      });

                                      User user = await Auth().signInWithEmailAndPassword(_email, _password );

                                      setState(() {
                                        _isProcessing = false;
                                      });

                                      if (user != null) {
                                        Navigator.of(context)
                                            .pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) => LandingPage(),  *//*ProfilePage(user: user),*//*
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(width: 24.0),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            RegisterPage(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Register',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }*/
}