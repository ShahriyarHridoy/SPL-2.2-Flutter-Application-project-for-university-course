import 'dart:io';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:visit_bangladesh/authentication/components/form_input_field_with_icon.dart';
import 'package:visit_bangladesh/authentication/components/form_vertical_spacing.dart';
import 'package:visit_bangladesh/authentication/components/label_button.dart';
import 'package:visit_bangladesh/authentication/components/loading_screen.dart';
import 'package:visit_bangladesh/authentication/components/logo_graphic_header.dart';
import 'package:visit_bangladesh/authentication/components/primary_button.dart';
import 'package:visit_bangladesh/authentication/landing_page.dart';
import 'package:visit_bangladesh/authentication/sign_in/validators.dart';
import 'package:visit_bangladesh/services/auth.dart';
import 'package:visit_bangladesh/services/myUserAuth.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerFormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();


  String get _name => _nameTextController.text;
  String get _email => _emailTextController.text;
  String get _password => _passwordTextController.text;

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;


  Widget build(BuildContext context) {
    bool _loading = false;

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
                      controller: _nameTextController,
                      iconPrefix: Icons.person,
                      labelText: "Name",
                      validator: (value) => Validator.validateName(
                          name: value,
                      ),
                      onChanged: (value) => null,
                      onSaved: (value) => _nameTextController.text = value,
                    ),
                    FormVerticalSpace(),
                    FormInputFieldWithIcon(
                      controller: _emailTextController,
                      iconPrefix: Icons.email,
                      labelText: "Email",
                      validator: (value) => Validator.validateEmail(
                        email: value,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => null,
                      onSaved: (value) => _emailTextController.text = value,
                    ),
                    FormVerticalSpace(),
                    FormInputFieldWithIcon(
                      controller: _passwordTextController,
                      iconPrefix: Icons.lock,
                      labelText: "Password",
                      validator: (value) => Validator.validatePassword(
                        password: value,
                      ),
                      obscureText: true,
                      maxLines: 1,
                      onChanged: (value) => null,
                      onSaved: (value) => _passwordTextController.text = value,
                    ),
                    FormVerticalSpace(),
                    PrimaryButton(
                        labelText: "Sign Up",
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            SystemChannels.textInput.invokeMethod(
                                'TextInput.hide'); //to hide the keyboard - if any

                                User user = await MyUserAuth
                                .registerUsingEmailPassword(_name, _email, _password,);

                            if (user == null) {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text(" Try Again"),
                              ));
                            }
                            if (user != null) {
                              Navigator.of(context)
                                  .pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => LandingPage(),
                                ),
                                ModalRoute.withName('/'),
                              );
                            }
                          }
                        }),
                    FormVerticalSpace(),
                    LabelButton(
                      labelText: "Sign In",
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, '/'),
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

  /*chooseImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile?.path));
    });
    if (pickedFile.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file.path));
      });
    } else {
      print(response.file);
    }
  }

  Future uploadFile() async {
    int i = 1;

    for (var img in _image) {
      setState(() {
        val = i / _image.length;
      });
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/${Path.basename(img.path)}');
      await ref.putFile(img).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          imgRef.add({'url': value});
          i++;
        });
      });
    }
  }*/

  /*@override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusName.unfocus();
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Register'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _registerFormKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _nameTextController,
                        focusNode: _focusName,
                        validator: (value) => Validator.validateName(
                          name: value,
                        ),
                        decoration: InputDecoration(
                          hintText: "Name",
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
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
                      SizedBox(height: 16.0),
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
                      SizedBox(height: 32.0),
                      _isProcessing
                          ? CircularProgressIndicator()
                          : Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  _isProcessing = true;
                                });

                                if (_registerFormKey.currentState
                                    .validate()) {
                                  User user = await Auth()
                                      .registerUsingEmailPassword(_name, _email, _password,);

                                  setState(() {
                                    _isProcessing = false;
                                  });

                                  if (user != null) {
                                    Navigator.of(context)
                                        .pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) => LandingPage(), *//*ProfilePage(user: user),*//*
                                      ),
                                      ModalRoute.withName('/'),
                                    );
                                  }
                                }
                              },
                              child: Text(
                                'Sign up',
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
          ),
        ),
      ),
    );
  }*/
}