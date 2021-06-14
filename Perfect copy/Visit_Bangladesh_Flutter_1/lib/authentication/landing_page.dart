
import 'package:flutter/material.dart';
//import 'package:visit_bangladesh/all_side_bar/pages/logoutpage.dart';
import 'package:visit_bangladesh/all_side_bar/sidebar/sidebar.dart';
import 'package:visit_bangladesh/authentication/sign_in/sign_in_page.dart';
import 'package:visit_bangladesh/services/auth.dart';


class LandingPage extends StatelessWidget {
  LandingPage({@required this.auth});
  final AuthBase auth;
  /*@override
  _LandingPageStateState createState() => _LandingPageStateState();
}

class _LandingPageStateState extends State<LandingPage> {*/
  /*UserInf _user;

  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
    widget.auth.authStateChanges().listen((user) {
      print('user: ${user?.uid}');
    });
  }

  void _checkCurrentUser() async{
    UserInf user = await widget.auth.currentUser();
    _updateUser(user);
  }

  void _updateUser(UserInf user){
    print('User id: ${user.uid}');
    setState(() {
      _user = user;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserInf>(
      stream: auth.authStateChanges(),
      // ignore: missing_return
      builder: (context, snapshot){

        if (snapshot.connectionState == ConnectionState.active){
          UserInf user = snapshot.data;

          if(user == null) {
            return SignInState(auth: auth);
          }
          return SideBarLayout(
            auth: auth,
            //onSignOut: () => _updateUser(null),
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      }
    );

    //return SideBarPage();
    //return Container();
  }
}
