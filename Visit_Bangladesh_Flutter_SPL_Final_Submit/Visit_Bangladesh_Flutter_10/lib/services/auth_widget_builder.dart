import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visit_bangladesh/authentication/user_model.dart';
import 'package:visit_bangladesh/services/myUserAuth.dart';

//https://www.youtube.com/watch?v=B0QX2woHxaU from this tutorial
class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder({Key key, @required this.builder}) : super(key: key);
  final Widget Function(BuildContext, AsyncSnapshot<User>) builder;

  @override
  Widget build(BuildContext context) {
    //final authService = Provider.of<MyUserAuth>(context, listen: false);
    return StreamBuilder<User>(
      stream: MyUserAuth.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        final User user = snapshot.data;
        if (user != null) {
          /*
          * For any other Provider services that rely on user data can be
          * added to the following MultiProvider list.
          * Once a user has been detected, a re-build will be initiated.
          */
          return MultiProvider(
            providers: [
              Provider<User>.value(value: user),
              // ignore: missing_required_param
              StreamProvider<UserModel>.value(
                  value: MyUserAuth.streamFirestoreUser(user))
            ],
            child: builder(context, snapshot),
          );
        }
        return builder(context, snapshot);
      },
    );
  }
}
