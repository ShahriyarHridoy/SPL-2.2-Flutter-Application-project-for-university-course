import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:visit_bangladesh/authentication/components/avatar.dart';
import 'package:visit_bangladesh/authentication/components/form_input_field_with_icon.dart';
import 'package:visit_bangladesh/authentication/components/form_vertical_spacing.dart';
import 'package:visit_bangladesh/authentication/components/loading_screen.dart';
import 'package:visit_bangladesh/authentication/components/primary_button.dart';
import 'package:visit_bangladesh/authentication/sign_in/validators.dart';
import 'package:visit_bangladesh/authentication/user_model.dart';
import 'package:visit_bangladesh/services/auth.dart';
import 'package:visit_bangladesh/services/myUserAuth.dart';
import 'package:path/path.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';

class AccountPage extends StatelessWidget with NavigationStates {
  String _uid = '';
  String _name = '';
  String _email = '';


  final _registerFormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  String get _nameNew => _nameTextController.text;
  String get _emailNew => _emailTextController.text;
  String get _passwordNew => _passwordTextController.text;

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  Widget build(BuildContext context) {
    return StreamBuilder<UserModel>(
        stream: MyUserAuth.getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            UserModel user = snapshot.data;
            if (user != null) {
              _uid = user.uid;
              _name = user.name;
              _email = user.email;
              _nameTextController.text = user.name;
              _emailTextController.text = user.email;
            }
            return Scaffold(
              appBar: AppBar(
                title: Text('Profile'),
                actions: [
                  IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        //Navigator.of(context).pushNamed('/settings');
                      }),
                ],
              ),
              body: LoadingScreen(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 120),
                      Avatar(user),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FormVerticalSpace(),
                          Text('User ID' + ': ' + _uid,
                              style: TextStyle(fontSize: 16)),
                          FormVerticalSpace(),
                          Text('User Name' + ': ' + _name,
                              style: TextStyle(fontSize: 16)),
                          FormVerticalSpace(),
                          Text('Email' + ': ' + _email,
                              style: TextStyle(fontSize: 16)),
                          FormVerticalSpace(),
                          /*Text(labels.home.adminUserLabel + ': ' + _admin,
                      style: TextStyle(fontSize: 16)),*/
                        ],
                      ),
                        ElevatedButton(
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            if ( user.uid != null){
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Center(
                                      child: Text("Edit your Profile"),
                                    ),
                                    insetPadding: EdgeInsets.symmetric(
                                        horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.08),
                                    content: SingleChildScrollView(
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 16,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            ),
                                            Center(
                                              child: Stack(
                                                //tag: 'User Avatar Image',
                                                children: [
                                                  CircleAvatar(
                                                      foregroundColor:
                                                      Colors.blue,
                                                      backgroundColor:
                                                      Colors.white,
                                                      radius: 70.0,
                                                      child: ClipOval(
                                                        child: Material(
                                                          color:
                                                          Colors.transparent,
                                                          child: Ink.image(
                                                            image: NetworkImage(
                                                              user.photoUrl,
                                                            ),
                                                            fit: BoxFit.cover,
                                                            width: 128,
                                                            height: 128,
                                                            child: InkWell(
                                                              onTap: () async {
                                                                final image =
                                                                await ImagePicker()
                                                                    .pickImage(
                                                                    source:
                                                                    ImageSource.gallery);

                                                                if (image == null)
                                                                  return;

                                                                final directory =
                                                                await getApplicationDocumentsDirectory();
                                                                final name =
                                                                basename(image
                                                                    .path);
                                                                final imageFile =
                                                                File(
                                                                    '${directory.path}/$name');
                                                                final newImage =
                                                                await File(image
                                                                    .path)
                                                                    .copy(imageFile
                                                                    .path);
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      )),
                                                  /*Positioned(
                                                  bottom: 0,
                                                  right: 4,
                                                  child: Container(
                                                    padding: EdgeInsets.all(8),
                                                    child: Icon(
                                                       Icons.add_a_photo,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),*/
                                                ],
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: <Widget>[
                                                FormVerticalSpace(),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                FormInputFieldWithIcon(
                                                  controller: _nameTextController,
                                                  iconPrefix: Icons.person,
                                                  labelText: "Name",
                                                  validator: (value) =>
                                                      Validator.validateName(
                                                        name: value,
                                                      ),
                                                  onChanged: (value) => null,
                                                  onSaved: (value) =>
                                                  _nameTextController.text =
                                                      value,
                                                ),
                                                FormVerticalSpace(),
                                                FormInputFieldWithIcon(
                                                  controller:
                                                  _emailTextController,
                                                  iconPrefix: Icons.email,
                                                  labelText: "Email",
                                                  validator: (value) =>
                                                      Validator.validateEmail(
                                                        email: value,
                                                      ),
                                                  keyboardType:
                                                  TextInputType.emailAddress,
                                                  onChanged: (value) => null,
                                                  onSaved: (value) =>
                                                  _emailTextController.text =
                                                      value,
                                                ),
                                                /*FormVerticalSpace(),
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
                                              ),*/
                                                FormVerticalSpace(),
                                                Center(
                                                  child: PrimaryButton(
                                                      labelText: "Save Details",
                                                      onPressed: () async {
                                                        if (_formKey.currentState
                                                            .validate()) {
                                                          SystemChannels.textInput
                                                              .invokeMethod(
                                                              'TextInput.hide'); //to hide the keyboard - if any

                                                          //User user = await MyUserAuth.registerUsingEmailPassword(_name, _email, _password,);

                                                          if (user == null) {
                                                            _scaffoldKey
                                                                .currentState
                                                                .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                      " Try Again"),
                                                                ));
                                                          }
                                                          if (user != null) {
                                                            AccountPage();
                                                          }
                                                        }
                                                      }),
                                                ),
                                                FormVerticalSpace(),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: Text("Close"),
                                        onPressed: () {
                                          _nameTextController.text = user.name;
                                          _emailTextController.text = user.email;
                                          AccountPage();
                                          Navigator.of(context).pop();
                                          /*Navigator.of(context)
                                            .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) => AccountPage(),
                                          ),
                                          ModalRoute.withName('/'),
                                        );*/
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                        )

                    ],
                  ),
                ),
                //inAsyncCall: _loading,
                color: Theme.of(context).scaffoldBackgroundColor,
                inAsyncCall: false,
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  /*Widget build(BuildContext context) {
    Stream<UserModel> user = MyUserAuth.streamFirestoreUser();


    //_isUserAdmin();

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                //Navigator.of(context).pushNamed('/settings');
              }),
        ],
      ),
      body: LoadingScreen(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 120),
              Avatar(user),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FormVerticalSpace(),
                  Text('User ID' + ': ' + _uid,
                      style: TextStyle(fontSize: 16)),
                  FormVerticalSpace(),
                  Text('User Name' + ': ' + _name,
                      style: TextStyle(fontSize: 16)),
                  FormVerticalSpace(),
                  Text('Email' + ': ' + _email,
                      style: TextStyle(fontSize: 16)),
                  FormVerticalSpace(),
                  */ /*Text(labels.home.adminUserLabel + ': ' + _admin,
                      style: TextStyle(fontSize: 16)),*/ /*
                ],
              ),
            ],
          ),
        ),
        inAsyncCall: _loading,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }*/

  /*_isUserAdmin() async {
    bool _isAdmin = await AuthService().isAdmin();
    //handle setState bug  //https://stackoverflow.com/questions/49340116/setstate-called-after-dispose
    if (mounted) {
      setState(() {
        _admin = _isAdmin.toString();
      });
    }
  }*/
}
