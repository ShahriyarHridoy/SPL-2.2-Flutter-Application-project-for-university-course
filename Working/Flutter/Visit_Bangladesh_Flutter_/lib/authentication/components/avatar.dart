import 'package:flutter/material.dart';
import 'package:visit_bangladesh/authentication/components/logo_graphic_header.dart';
import 'package:visit_bangladesh/authentication/user_model.dart';
import 'package:visit_bangladesh/services/auth.dart';

class Avatar extends StatelessWidget {
  Avatar(
    this.user,
  );
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    if ((user?.photoUrl == '') || (user?.photoUrl == null)) {
      return LogoGraphicHeader();
    }
    print(user.photoUrl);
    return Hero(
      tag: 'User Avatar Image',
      child: CircleAvatar(
          foregroundColor: Colors.blue,
          backgroundColor: Colors.white,
          radius: 70.0,
          child: ClipOval(
            child: Image.network(
              user?.photoUrl,
              fit: BoxFit.cover,
              //width: 120.0,
              //height: 120.0,
            ),
          )),
    );
  }
}