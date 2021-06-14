import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:visit_bangladesh/all_side_bar/pages/logoutpage.dart';
import 'package:visit_bangladesh/all_side_bar/sidebar/sidebar.dart';
import 'package:visit_bangladesh/all_side_bar/sidebar/sidebar_layout.dart';
import 'package:visit_bangladesh/all_side_bar/sidebar/sidebar_menu.dart';
import 'package:visit_bangladesh/authentication/sign_in/sign_in_page.dart';

class LandingPageState extends StatefulWidget {
  @override
  _LandingPageStateState createState() => _LandingPageStateState();
}

class _LandingPageStateState extends State<LandingPageState> {
  User _user;

  void _updateUser(User user){
    print('User id: ${user.uid}');
    setState(() {
      _user = user;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(_user == null) {
      return SignInPage(
        onSignIn: _updateUser,
      );
    }
    return SideBarLayout(
        onSignOut: () => _updateUser(null),
    );
    //return SideBarPage();
    //return Container();
  }
}
