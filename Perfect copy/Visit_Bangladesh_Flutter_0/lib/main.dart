import 'package:flutter/material.dart';
import 'package:visit_bangladesh/authentication/landing_page.dart';

import 'all_side_bar/sidebar/sidebar_layout.dart';
import 'authentication/sign_in/sign_in_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final signInpage = SignInPage();
    // signInpage._buildContent();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //title: "Visit Bangladesh",
      theme: ThemeData(
        //scaffoldBackgroundColor: Colors.yellow,
        primaryColor: Colors.white,
      ),
      //home: SideBarLayout(),
      home: LandingPageState(),
      //home: SignInPage(),
    );
  }
}
