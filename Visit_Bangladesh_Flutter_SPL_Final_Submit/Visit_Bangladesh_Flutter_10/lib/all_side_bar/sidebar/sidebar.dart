import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:visit_bangladesh/authentication/components/avatar.dart';
import 'package:visit_bangladesh/authentication/user_model.dart';
import 'package:visit_bangladesh/common_widgets/platform_alert_dialog.dart';
import 'package:visit_bangladesh/services/myUserAuth.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';
import 'menu_item.dart';

class SideBarLayout extends StatelessWidget {
  //SideBarLayout(LogoutPage logoutPage);

  @override
  Widget build(BuildContext context) {
    /*if(onSignOut != null){
      _signOut();
      print('hello');
    }*/
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

class SideBar extends StatefulWidget {
  @override
  SideBarState createState() => SideBarState();
}

class SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  AnimationController _animationController;
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;
  final _animationDuration = const Duration(milliseconds: 500);
  //final sidebarLayout = SideBarLayout();

  Future<void> _signOut(BuildContext context) async {
    try {
      await MyUserAuth.signOut();
      //LandingPage();
    } catch (e) {
      print(e.toString());
    }
  }


  Future<void> _confirmSignOut(BuildContext context) async {

    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    ).show(context);
    if (didRequestSignOut == true) {
      uid = '';
      name = '';
      email = '';
      profileImageUrl=null;
      _signOut(context);
    }
  }


  static String uid = '';
  static String name = '';
  static String email = '';
  static String profileImageUrl = '';
  UserModel _user ;

  Widget _getProfileInfo(BuildContext context) {
    return StreamBuilder<UserModel>(
      stream: MyUserAuth.getUserInfo(),
      builder: (context, snapshot) {
        if (snapshot!=null && !snapshot.hasError) {
          if (snapshot.connectionState == ConnectionState.active) {
            _user = snapshot.data;
            if (_user != null) {
              uid = _user.uid;
              name = _user.name;
              email = _user.email;
              if ((_user?.photoUrl == '') || (_user?.photoUrl == null)) {
                profileImageUrl = 'assets/images/default.png';
              } else {
                profileImageUrl = _user.photoUrl;
              }
            }
          } else {
            profileImageUrl = 'assets/images/default.png';
          }
        }
        return SizedBox();
      },
    );
  }

  @override
  void initState() {
    //_buildProductsList();
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  static const platform = const MethodChannel('sendSms');

  /*Future<Null> sendSms() async {
    print("SendSMS");
    try {
      final String result = await platform.invokeMethod(
          'send', <String, dynamic>{
        "phone": "+8801521432437",
        "msg": "Hello! I'm sent programatically."
      });
      print(result);
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSideBarOpenedAsync.data ? 0 : -screenWidth,
          right: isSideBarOpenedAsync.data ? 0 : screenWidth - 45,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: const Color(0xFF096089),
                  child: ListView(
                    children: <Widget>[
                      _getProfileInfo(context),
                      SizedBox(
                        height: 65,
                      ),
                      /*StreamBuilder<UserModel>(
                          stream: MyUserAuth.getUserInfo(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.active) {
                              UserModel user = snapshot.data;
                              if (user != null) {
                                _uid = user.uid;
                                _name = user.name;
                                _email = user.email;
                              }
                            }
                          }),*/

                      ListTile(
                        title: Text(
                          name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w800),
                        ),
                        //horizontalTitleGap: 5,
                        //minVerticalPadding: 20,
                        subtitle: Text(
                          email,
                          style: TextStyle(
                            color: Color(0xFF1BB5FD),
                            fontSize: 18,
                          ),
                        ),
                        leading: CircleAvatar(
                            foregroundColor: Colors.blue,
                            backgroundColor: Colors.white,
                            radius: 40.0,
                            child: ClipOval(
                              child: Avatar(_user),
                            )),
                      ),
                      SizedBox(height: 10,),
                      MenuItem(
                          icon: Icons.highlight_off,
                          title: "Emergency",
                          onTap: () {
                            /*showDialog(
                                context: context,
                                builder: (context){
                                  return AlertDialog(
                                    //title: Center(child: Text("Train Route"),),
                                    insetPadding:  EdgeInsets.symmetric(
                                        horizontal: MediaQuery.of(context).size.width * 0.08),
                                    content: ListView(children: <Widget>[
                                      Center(
                                          child: Text(
                                            'People-Chart',
                                            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                                          )),
                                      DataTable(
                                        columns: [
                                          DataColumn(label: Text(
                                              'ID',
                                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                                          )),
                                          DataColumn(label: Text(
                                              'Name',
                                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                                          )),
                                          DataColumn(label: Text(
                                              'Profession',
                                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                                          )),
                                        ],
                                        rows: [
                                          DataRow(cells: [
                                            DataCell(Text('1')),
                                            DataCell(Text('Stephen')),
                                            DataCell(Text('Actor')),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Text('5')),
                                            DataCell(Text('John')),
                                            DataCell(Text('Student')),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Text('10')),
                                            DataCell(Text('Harry')),
                                            DataCell(Text('Leader')),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Text('15')),
                                            DataCell(Text('Peter')),
                                            DataCell(Text('Scientist')),
                                          ]),
                                        ],
                                      ),
                                    ]),
                                    actions: [
                                      TextButton(
                                        child: Text("Close"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                }
                            );*/
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.EmergencyContractClickedEvent);
                          }
                      ),
                      Divider(
                        height: 30,
                        thickness: 1,
                        color: Colors.white.withOpacity(0.3),
                        indent: 30,
                        endIndent: 30,
                      ),
                      MenuItem(
                        icon: Icons.home,
                        title: "Home",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.HomePageClickedEvent);
                        },
                      ),
                      MenuItem(
                        icon: Icons.person,
                        title: "My Account",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.MyAccountClickedEvent);
                          //Navigator.pushReplacementNamed(context, '/profilepage');
                        },
                      ),
                      MenuItem(
                        icon: Icons.cloud_done,
                        title: "Weather Update",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.WeatherCheckClickedEvent);
                        },
                      ),
                      MenuItem(
                        icon: Icons.attach_money,
                        title: "Convert Currency",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context).add(
                              NavigationEvents
                                  .CurrencyConvertCheckClickedEvent);
                        },
                      ),

                      MenuItem(
                        icon: Icons.travel_explore,
                        title: "Add New Tourist Place",
                        onTap: () {
                          if(_user!= null){
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.MyOrdersClickedEvent);
                          };
                        },
                      ),

                      MenuItem(
                        icon: Icons.place_outlined,
                        title: "My Places",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context).add(
                              NavigationEvents
                                  .MyPlacesCheckClickedEvent);
                        },
                      ),

                      /*MenuItem(
                        icon: Icons.card_giftcard,
                        title: "Forms Check",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.FormCheckClickedEvent);
                        },
                      ),*/

                      Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 32,
                        endIndent: 32,
                      ),
                      /*MenuItem(
                        icon: Icons.settings,
                        title: "Settings",
                      ),*/
                      MenuItem(
                          icon: Icons.exit_to_app,
                          title: "Logout",
                          onTap: () {
                            onIconPressed();
                            _confirmSignOut(context);
                            //Navigator.of(context).popUntil((route) => route == null);
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => LandingPage()));
                          }
                          /*onTap: () {
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.LogoutClickedEvent);
                          },*/
                          /*onTap:(){
                            Navigator.of(context).popUntil((route) => route == null);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SideBarLayout(onSignOut: null)));
                          },*/
                          ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, -0.9),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 35,
                      height: 110,
                      color: Color(0xFF096089),
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: Color(0xFF1BB5FD),
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
