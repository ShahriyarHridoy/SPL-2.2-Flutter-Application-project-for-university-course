import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:visit_bangladesh/authentication/landing_page.dart';
import 'package:visit_bangladesh/services/auth.dart';

import 'all_side_bar/sidebar/sidebar_layout.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final SignInPage = SignInPage();
    // signInpage._buildContent();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //title: "Visit Bangladesh",
      theme: ThemeData(
        //scaffoldBackgroundColor: Colors.yellow,
        primaryColor: Colors.white,
      ),
      //home: SideBarLayout(),
      home: LandingPage(
        auth: Auth(),
      ),
      //home: SignInPageState(),
    );
  }
}
