import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc.navigation_bloc/navigation_bloc.dart';
import 'sidebar.dart';

class SideBarLayout1 extends StatelessWidget {
  //SideBarLayout(LogoutPage logoutPage);

  int val;
  SideBarLayout1({@required this.onSignOut});
  final VoidCallback onSignOut;

  Future<Void> _signOut() async{
    //await Firebase.initializeApp();
    try{
      await FirebaseAuth.instance.signOut();
      onSignOut();
      //print('${authResult.user.uid}');
    } catch(e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if(onSignOut != null){
      _signOut();
      print('hello');
    }
    return Scaffold(
      body: BlocProvider<NavigationBloc>(
        create: (context) => NavigationBloc(),
        child: Stack(
          children: <Widget>[
            BlocBuilder<NavigationBloc, NavigationStates>(
              builder: (context, navigationState) {
                return navigationState as Widget;
              },
            ),
            SideBar(),
          ],
        ),
      ),
    );
  }
}
