
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:visit_bangladesh/authentication/landing_page.dart';
import 'package:visit_bangladesh/routes.dart';
import 'package:visit_bangladesh/splashpage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: Routes.routes,
            title: 'Visit Bangladesh',
            theme: ThemeData(
              primarySwatch: Colors.blueGrey,
            ),
            home: SplashPage(duration:3, goToPage: LandingPage()),
          );



      /*child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: Routes.routes,
        title: 'Visit Bangladesh',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: LandingPage(),
      ),*/

    /*return Provider<AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Visit Bangladesh',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: LandingPage(),
      ),
    );*/
  }
}
