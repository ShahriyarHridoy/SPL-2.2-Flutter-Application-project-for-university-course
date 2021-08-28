
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:visit_bangladesh/all_side_bar/pages/formpage.dart';
import 'package:visit_bangladesh/all_side_bar/sidebar/sidebar.dart';
import 'package:visit_bangladesh/authentication/sign_in/sign_in_page.dart';
import 'package:visit_bangladesh/authentication/user_model.dart';
import 'package:visit_bangladesh/services/auth.dart';
import 'package:visit_bangladesh/services/myUserAuth.dart';


class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: MyUserAuth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user == null) {
              return SignInState(isLoading: false);
            }
            return SideBarLayout();
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}