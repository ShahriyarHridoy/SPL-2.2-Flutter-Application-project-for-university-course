
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:visit_bangladesh/all_side_bar/pages/logoutpage.dart';
import 'package:visit_bangladesh/all_side_bar/sidebar/sidebar.dart';
import 'package:visit_bangladesh/authentication/sign_in/sign_in_page.dart';
import 'package:visit_bangladesh/services/auth.dart';


class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return StreamBuilder<UserInf>(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            UserInf user = snapshot.data;
            if (user == null) {
              return SignInState.create(context);
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