import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visit_bangladesh/all_side_bar/location/horizontal_division.dart';
import 'package:visit_bangladesh/all_side_bar/location/horizontal_place_item.dart';
import 'package:visit_bangladesh/all_side_bar/location/place_model.dart';
import 'package:visit_bangladesh/all_side_bar/location/vertical_place_item.dart';
import 'package:visit_bangladesh/authentication/components/grid_search.dart';
import 'package:visit_bangladesh/common_widgets/custom_raised_button.dart';
import 'package:visit_bangladesh/services/myUserAuth.dart';
import 'package:visit_bangladesh/util/division_details.dart';
import 'package:visit_bangladesh/util/places.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';

/*class HomePage extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "HomePage",
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
      ),
    );
  }
}*/
class HomePage extends StatefulWidget with NavigationStates {
  static List<PlaceModel> placeModels = [];

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /*Widget _biuldGoad() {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, top: 20, bottom: 50),
      child: Container(
        width: 160.0,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xffE2FFF1),
          boxShadow: [
            BoxShadow(
                blurRadius: 4,
                offset: Offset(0, 4),
                color: Colors.black12,
                spreadRadius: 2)
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              child: Image(
                image: AssetImage(
                  'assets/images/pic1.jpg',
                ),
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: CircleAvatar(
                radius: 12,
                child: Image.asset('assets/images/avatar.png'),
              ),
            ),
            Positioned(
              top: 10,
              left: 25,
              child: CircleAvatar(
                radius: 12,
                child: Image.asset('assets/images/avatar.png'),
              ),
            ),
            Positioned(
              top: 10,
              left: 40,
              child: CircleAvatar(
                radius: 12,
                child: Image.asset('assets/images/avatar.png'),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Everest",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 30,
              child: Padding(
                padding: const EdgeInsets.only(left: 35.0),
                child: Text(
                  "62 % complete",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }*/

  @override
  void initState() {
    MyUserAuth.db.collection("place_details").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        PlaceModel model = PlaceModel.fromMap(result.data());
        if (model != null) {
          if (model.placeName != null && model.placeName.isNotEmpty) {
            bool isFound = false;
            for (int i = 0; i < HomePage.placeModels.length; i++) {
              if (HomePage.placeModels.elementAt(i).placeName ==
                  model.placeName) {
                isFound = true;
                break;
              }
            }
            if (!isFound) HomePage.placeModels.add(model);
          }
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.blueGrey,
                  child: Stack(
                    fit: StackFit.loose,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(),
                        child: Image.asset(
                          'assets/images/visit_bd_cover.png',
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            /*Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Image.asset('assets/images/bell.png'),
                              ],
                            ),*/
                            Center(
                              child: Text(
                                "Welcome To",
                                style: GoogleFonts.permanentMarker(
                                  textStyle: TextStyle(
                                    color: Color(0xff00052A),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            )
                            /*    Padding(
                              padding: EdgeInsets.only(top: 30.0),
                              child: Text(
                                "Hey Mike,",
                                style: TextStyle(
                                  color: Color(0xFFF5F6FC),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 21,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 200),
                              child: Text(
                                "Wander Without Purpose",
                                style: TextStyle(
                                  color: Color(0xff00052A),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 21,
                                ),
                              ),
                            )*/
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Center(
                    child: Container(
                      width: double.infinity,
                      color: Theme.of(context).accentColor,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            //SizedBox(height: 5),
                            Center(
                              child: Container(
                                padding: EdgeInsets.only(left: 10, top: 5),
                                child: Text(
                                  "Your Travel Goals  😍",
                                  style: TextStyle(
                                    color: Color(0xff00052A),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: Container(
                                //padding: EdgeInsets.only(left: 10, top: 5),
                                child: Text(
                                  "Choose the Division, Where You want to Go",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 400,
                              margin: EdgeInsets.only(left: 15),
                              child: ListView.builder(
                                //scrollDirection: Axis.horizontal,
                                scrollDirection: Axis.vertical,
                                primary: false,
                                itemCount:
                                    divisions == null ? 0.0 : divisions.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Map place =
                                      divisions.reversed.toList()[index];
                                  return HorizontalDivision(division: place);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //SizedBox(height: 30),
          SlideUpWidget()
        ],
      ),
    );
  }
}

class SlideUpWidget extends StatefulWidget {
  SlideUpWidget({Key key}) : super(key: key);

  @override
  _SlideUpWidgetState createState() => _SlideUpWidgetState();
}

class _SlideUpWidgetState extends State<SlideUpWidget> {
  bool _isClosedSlidePanel = true;

  /*Widget _biuldFriendItem(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20.0, bottom: 20),
      child: Container(
          width: MediaQuery.of(context).size.width - 70,
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300],
                  blurRadius: 4,
                  spreadRadius: 2,
                  offset: Offset(0.0, 4)),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(28)),
                        child: Image(
                          image: AssetImage('assets/images/pic1.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: CircleAvatar(
                          radius: 15,
                          child: Image.asset('assets/images/avatar.png'),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 25,
                        child: CircleAvatar(
                          radius: 15,
                          child: Image.asset('assets/images/avatar.png'),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 40,
                        child: CircleAvatar(
                          radius: 15,
                          child: Image.asset('assets/images/avatar.png'),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                "112",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.star_border,
                                size: 22,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          text: "Kyle",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff00052A),
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: " @Loch Ness",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff949AA8)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          text: "@Jenifer92",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).accentColor,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  " Hear we are most awaited journey end. Let see the moster 😍",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff949AA8)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      RichText(
                        text: TextSpan(
                          text: "Nolan",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff00052A),
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: " Did you catch the moster? 😃",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff949AA8)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      RichText(
                        text: TextSpan(
                          text: "Anne",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff00052A),
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: " Awsomeee 😆😍",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff949AA8)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      onPanelOpened: () {
        setState(() {
          _isClosedSlidePanel = false;
        });
      },
      onPanelClosed: () {
        setState(() {
          _isClosedSlidePanel = true;
        });
      },
      maxHeight: MediaQuery.of(context).size.height - 5,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(35.0),
        topRight: Radius.circular(20.0),
      ),
      boxShadow: [BoxShadow(offset: Offset(-1, 0), color: Colors.grey)],
      panel: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                ),
              ],
            ),
          ),
          _isClosedSlidePanel
              ? SizedBox(
                  height: 0,
                )
              : Container(
                  margin: EdgeInsets.only(left: 40, right: 20),
                  // ignore: deprecated_member_use
                  child: Container(
                    padding: EdgeInsets.all(20),

                    child: RaisedButton(
                        child: Center(child: Text(
                          "Search  Places",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,),
                        ),),
                        color: Colors.blueGrey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => GridSearchScreen()));
                        }),
                  ),
                ),
          //SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Recommended Places",
                  style: TextStyle(
                      color: Color(0xff949AA8),
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(width: 4),
                Text(
                  "&",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 19,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 4),
                Text(
                  "All Tourist Places",
                  style: TextStyle(
                      color: Color(0xff949AA8),
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          //SizedBox(height: 5),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            height: 230.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              primary: false,
              itemCount: HomePage.placeModels == null
                  ? 0
                  : HomePage.placeModels.length,
              itemBuilder: (BuildContext context, int index) {
                PlaceModel popularPlaces = HomePage.placeModels[index];
                print(popularPlaces);
                return HorizontalPlaceItem(place: popularPlaces);
              },
              /*children: <Widget>[
                _biuldDhakaPlacesItem(),
                _biuldDhakaPlacesItem(),
                _biuldDhakaPlacesItem(),
                _biuldDhakaPlacesItem(),
              ],*/
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "All The Tourist Places",
              style: TextStyle(
                  color: Color(0xff949AA8),
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
          //SizedBox(height: 10),
          Expanded(
            //padding: EdgeInsets.all(10.0),
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              primary: false,
              //physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: HomePage.placeModels == null
                  ? 0
                  : HomePage.placeModels.length,
              itemBuilder: (BuildContext context, int index) {
                PlaceModel divPlaces = HomePage.placeModels[index];
                return VerticalPlaceItem(place: divPlaces);
              },
            ),
          ),

          /*Expanded(
            child: ListView(
              //padding: const EdgeInsets.all(8),
              children: <Widget>[
                _biuldFriendItem(context),
                _biuldFriendItem(context),
                _biuldFriendItem(context),
                _biuldFriendItem(context),
                _biuldFriendItem(context),
              ],
            ),
          )*/
        ],
      ),
    );
  }
}

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          size: 24,
          color: Colors.grey,
        ),
        hintText: 'Search places, Locations',
        alignLabelWithHint: true,
        hintStyle: TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            width: 0.5,
            style: BorderStyle.none,
            color: Colors.grey,
          ),
        ),
        filled: true,
        contentPadding: EdgeInsets.all(16),
        fillColor: Colors.white,
      ),
    );
  }
}
