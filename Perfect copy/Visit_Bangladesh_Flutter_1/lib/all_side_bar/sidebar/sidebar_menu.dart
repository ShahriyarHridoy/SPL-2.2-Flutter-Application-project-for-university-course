
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visit_bangladesh/all_side_bar/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:visit_bangladesh/all_side_bar/pages/homepage.dart';
import 'package:visit_bangladesh/all_side_bar/sidebar/menu_item.dart';

class SideBarPage extends StatefulWidget {
  @override
  _SideBarPageState createState() => _SideBarPageState();
}

class _SideBarPageState extends State<SideBarPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visit Bangladesh'),
        backgroundColor: Colors.deepOrange,
      ),
      drawer: Drawer(

        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          color: const Color(0xFF262AAA),
          child: ListView(
            children: <Widget>[
              /*DrawerHeader(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: <Color>[
                      Colors.deepOrange,
                      Colors.orangeAccent,
                    ])
                ),
                child: Container(
                  child: Column(
                    children: [
                      Material(
                        child: Image.asset(name),
                      )
                    ],
                  ),
                ),
              ),*/
              UserAccountsDrawerHeader(
                accountName: Text(
                  "Shahriyar",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),
                ),
                accountEmail: Text(
                  "www.facebook.com/shahriyar.ripon",
                  style: TextStyle(
                    //color: Color(0xFF1BB5FD),
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                currentAccountPicture: GestureDetector(
                    child: CircleAvatar(
                      backgroundImage: ExactAssetImage('assets/images/google-logo.png'),
                    ),
                    onTap: () => print("Current User")
                ),

                //.. This line of code provides the usage of multiple accounts
                /* otherAccountsPictures: <Widget>[
              GestureDetector(
                onTap: ()=> switchUser(),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(otherProfilePic)
                ),
              ),
            ], */

                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage("https://png.pngtree.com/thumb_back/fh260/background/20190828/pngtree-dark-vector-abstract-background-image_302715.jpg")
                  ),
                ),
              ),

              /*SizedBox(
                height: 80,
              ),
              ListTile(
                title: Text(
                  "Shahriyar",
                  style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800),
                ),
                subtitle: Text(
                  "www.facebook.com/shahriyar.ripon",
                  style: TextStyle(
                    color: Color(0xFF1BB5FD),
                    fontSize: 18,
                  ),
                ),
                leading: CircleAvatar(
                  child: Icon(
                    Icons.perm_identity,
                    color: Colors.white,
                  ),
                  radius: 40,
                ),
              ),*/
              Divider(
                height: 30,
                thickness: 1.5,
                color: Colors.white.withOpacity(0.3),
                indent: 10,
                endIndent: 10,
              ),

              MenuItem(
                icon: Icons.home,
                title: "Home",
                onTap: () {
                  //onIconPressed();
                  //BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.HomePageClickedEvent);
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(builder:
                      (BuildContext context) => HomePage(),
                  ));
                },
              ),
              MenuItem(
                icon: Icons.person,
                title: "My Account",
                onTap: () {
                  //onIconPressed();
                  BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.MyAccountClickedEvent);
                },
              ),
              MenuItem(
                icon: Icons.shopping_basket,
                title: "My Orders",
                onTap: () {
                  //onIconPressed();
                  BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.MyOrdersClickedEvent);
                },
              ),
              MenuItem(
                icon: Icons.card_giftcard,
                title: "Wishlist",
              ),
              Divider(
                height: 64,
                thickness: 0.5,
                color: Colors.white.withOpacity(0.3),
                indent: 32,
                endIndent: 32,
              ),
              MenuItem(
                icon: Icons.settings,
                title: "Settings",
              ),
              MenuItem(
                icon: Icons.exit_to_app,
                title: "Logout",
                //onTap: () => _signOut(),
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
    );
  }
}

class CustomListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: [
          Icon(Icons.person),
          Text('Profile'),
          Icon(Icons.arrow_right),
        ],
      ),
    );
  }
}
