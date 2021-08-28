import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visit_bangladesh/all_side_bar/location/icon_badge.dart';
import 'package:visit_bangladesh/all_side_bar/location/place_model.dart';
import 'package:visit_bangladesh/all_side_bar/pages/show_route_map.dart';
import 'package:visit_bangladesh/util/places.dart';

class Details extends StatelessWidget {

  final PlaceModel place;
  String url ;
  Details({this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          IconButton(
            icon: IconBadge(
              icon: Icons.notifications_none,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 10.0),
          buildSlider(),
          SizedBox(height: 20),
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            primary: false,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${place.placeName}",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  /*IconButton(
                    icon: Icon(
                      Icons.bookmark,
                    ),
                    onPressed: () {},
                  ),*/
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0),
                        child: Row(
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(10.0),
                              onTap: () {},
                              child: Icon(
                                CupertinoIcons.heart_fill,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            InkWell(
                              borderRadius: BorderRadius.circular(10.0),
                              onTap: () {},
                              child: Icon(
                                CupertinoIcons.chat_bubble,
                                size: 25.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      /*Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: StreamBuilder(
                                stream: likesRef
                                    .where('postId', isEqualTo: post.postId)
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasData) {
                                    QuerySnapshot snap = snapshot.data;
                                    List<DocumentSnapshot> docs = snap.docs;
                                    return buildLikesCount(
                                        context, docs?.length ?? 0);
                                  } else {
                                    return buildLikesCount(context, 0);
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 5.0),

                        ],
                      ),*/
                      // SizedBox(height: 5.0),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      size: 14,
                      color: Colors.blueGrey[300],
                    ),
                    SizedBox(width: 3),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${place.Division}"+ ", " + "${place.District}" + ", " + "${place.Upazila}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.blueGrey[300],
                        ),
                        maxLines: 1,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),

              //SizedBox(height: 20),
              SizedBox(height: 10.0),
              Container(
                height: 50.0,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  //padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ElevatedButton(
                        child: Text(
                          'Route Details',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                elevation: 16,
                                child: Container(
                                  child: ListView(
                                    shrinkWrap: true,
                                    children: <Widget>[
                                      SizedBox(height: 20),
                                      Center(
                                          child: Text(
                                        'Route Info',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      )),
                                      SizedBox(height: 20),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(30, 10, 30, 20),
                                        /*decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.blueAccent),
                                        ),*/
                                        child: Column(
                                          children: [
                                            /*SizedBox(
                                              width: double.infinity,
                                              child: ElevatedButton(
                                                onPressed: () {},
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.green,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                                  elevation: 5,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10, right: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: <Widget>[
                                                      Text(
                                                        "Bus Route",
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                          FontWeight.w700,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons.directions_bus_rounded,
                                                        color: Colors.white,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),*/
                                            SizedBox(
                                              width: double.infinity,
                                              child: ElevatedButton.icon(
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      /*return WillPopScope(
                                                          onWillPop: (){},
                                                          child: Dialog(
                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                                            elevation: 16,
                                                            child: Container(
                                                              width: 100.0,
                                                              height: 300.0,
                                                              child: ListView(
                                                                shrinkWrap: true,
                                                                children: <Widget>[
                                                                  SizedBox(height: 20),
                                                                  Center(child: Text('Leaderboard')),
                                                                  SizedBox(height: 20),

                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                      );*/
                                                      return AlertDialog(
                                                        title: Center(child: Text("Bus Route"),),
                                                        insetPadding:  EdgeInsets.symmetric(
                                                            horizontal: MediaQuery.of(context).size.width * 0.08),
                                                        content: SingleChildScrollView(
                                                          child: Container(
                                                            padding: EdgeInsets.all(10),
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(
                                                                  height: 16,
                                                                  width: MediaQuery.of(context).size.width,
                                                                ),
                                                                Text(
                                                                    "Details"+ ':  '+ "${place.busDetails}",
                                                                    style: TextStyle(fontSize: 16)
                                                                ),
                                                                /*Text("vvvvarlbebbirbiebbi5bfibi5bibi  fi3bbi4 ibi4b3b tgr"),
                                                                Text("vvvvarlbebbirbiebbi5bfibi5bibi  fi3bbi4 ibi4b3b tgr"),*/

                                                              ],
                                                            ),
                                                          ),

                                                        ),
                                                        actions: [
                                                          FlatButton(
                                                            child: Text("Close"),
                                                            onPressed: () {
                                                              Navigator.of(context).pop();
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                      /*return Dialog(

                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                                        elevation: 16,
                                                        child: Container(
                                                          child: ListView(
                                                            shrinkWrap: true,
                                                            children: <Widget>[
                                                              SizedBox(height: 20),
                                                              Center(child: Text('Bus Route')),
                                                              SizedBox(height: 20),

                                                            ],
                                                          ),
                                                        ),
                                                      );*/
                                                    },
                                                  );
                                                },
                                                icon: Icon(Icons
                                                    .directions_bus_rounded),
                                                label: Text(
                                                  "   Bus Route",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.green,
                                                  //fixedSize: Size(300, 100),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  elevation: 5,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: double.infinity,
                                              child: ElevatedButton.icon(
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: Center(child: Text("Train Route"),),
                                                        insetPadding:  EdgeInsets.symmetric(
                                                            horizontal: MediaQuery.of(context).size.width * 0.08),
                                                        content: SingleChildScrollView(
                                                          child: Container(
                                                            padding: EdgeInsets.all(10),
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(
                                                                  height: 16,
                                                                  width: MediaQuery.of(context).size.width,
                                                                ),
                                                                Text(
                                                                    "Details"+ ':  '+ "${place.trainDetails}",
                                                                    style: TextStyle(fontSize: 16)
                                                                ),

                                                              ],
                                                            ),
                                                          ),

                                                        ),
                                                        actions: [
                                                          TextButton(
                                                            child: Text("Close"),
                                                            onPressed: () {
                                                              Navigator.of(context).pop();
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                icon: Icon(
                                                  Icons.directions_railway,
                                                ),
                                                label: Text(
                                                  "   Train Route",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.green,
                                                  //fixedSize: Size(300, 100),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  elevation: 5,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: double.infinity,
                                              child: ElevatedButton.icon(
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: Center(child: Text("Lounge Route"),),
                                                        insetPadding:  EdgeInsets.symmetric(
                                                            horizontal: MediaQuery.of(context).size.width * 0.08),
                                                        content: SingleChildScrollView(
                                                          child: Container(
                                                            padding: EdgeInsets.all(10),
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(
                                                                  height: 16,
                                                                  width: MediaQuery.of(context).size.width,
                                                                ),
                                                                Text(
                                                                    "Details"+ ':  '+ "${place.launchDetails}",
                                                                    style: TextStyle(fontSize: 16)
                                                                ),

                                                              ],
                                                            ),
                                                          ),

                                                        ),
                                                        actions: [
                                                          TextButton(
                                                            child: Text("Close"),
                                                            onPressed: () {
                                                              Navigator.of(context).pop();
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                icon: Icon(
                                                  Icons.directions_boat_rounded,
                                                ),
                                                label: Text(
                                                  "    Lounge Route",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.green,
                                                  //fixedSize: Size(300, 100),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                                  elevation: 5,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Container(
                          height: 50.0,
                          width: 0.3,
                          color: Colors.grey,
                        ),
                      ),
                      ElevatedButton(
                        child: Text(
                          'Guide Details',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Center(child: Text("Guide Details"),),
                                insetPadding:  EdgeInsets.symmetric(
                                    horizontal: MediaQuery.of(context).size.width * 0.08),
                                content: SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 16,
                                          width: MediaQuery.of(context).size.width,
                                        ),
                                        Text(
                                            "Guide Name"+ ':  '+ "${place.guideName}",
                                            style: TextStyle(fontSize: 16)
                                        ),
                                        Text(
                                            "Guide Number"+ ':  '+ "${place.guideNumber}",
                                            style: TextStyle(fontSize: 16)
                                        ),
                                        ElevatedButton.icon(
                                          icon: Icon(Icons.phone),
                                          label: Text('Call Guide'),
                                          onPressed: (){
                                            url = "tel:${place.guideNumber}";
                                            _callNumber();
                                          }
                                        ),
                                          Text(
                                        "Guide Address"+ ':  '+ "${place.guideAddress}",
                                          style: TextStyle(fontSize: 16)
                                          ),

                                      ],
                                    ),
                                  ),

                                ),
                                actions: [
                                  TextButton(
                                    child: Text("Close"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Container(
                          height: 50.0,
                          width: 0.3,
                          color: Colors.grey,
                        ),
                      ),
                      ElevatedButton(
                        child: Text(
                          'Police Station',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Center(child: Text("Police Station Details"),),
                                insetPadding:  EdgeInsets.symmetric(
                                    horizontal: MediaQuery.of(context).size.width * 0.08),
                                content: SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 16,
                                          width: MediaQuery.of(context).size.width,
                                        ),
                                        Text(
                                            "Police Station Name"+ ':  '+ "${place.psNameDetails}",
                                            style: TextStyle(fontSize: 16)
                                        ),
                                        Text(
                                            "Station Number"+ ':  '+ "${place.psContactDetails}",
                                            style: TextStyle(fontSize: 16)
                                        ),
                                        ElevatedButton.icon(
                                            icon: Icon(Icons.phone),
                                            label: Text('Call Police'),
                                            onPressed: (){
                                              url = "tel:${place.psContactDetails}";
                                              _callNumber();
                                            }
                                        ),
                                        Text(
                                            "Station Incharge Name"+ ':  '+ "${place.psInchargeDetails}",
                                            style: TextStyle(fontSize: 16)
                                        ),

                                      ],
                                    ),
                                  ),

                                ),
                                actions: [
                                  TextButton(
                                    child: Text("Close"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Details",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${place.placeDetails}",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.0,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.airplanemode_active,
        ),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => ShowRouteMap(place.lat, place.lon)));
        },
      ),
    );
  }

  _callNumber() async{
    //set the number here
    print("call test ----------------------");
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch ${url}';
    }
  }


  buildSlider() {
    return Container(
      padding: EdgeInsets.only(left: 20),
      height: 250.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        primary: false,
        itemCount: place.imageUrl == null ? 0 : place.imageUrl.length,
        itemBuilder: (BuildContext context, int index) {
          print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
          var imgUrl = place.imageUrl[index];
          print(place.imageUrl.length);
          print(imgUrl);
          print('***********************************************************');

          return Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: ClipRRect(
                //borderRadius: BorderRadius.all(Radius.circular(28)),
                child: Image(
                  image: NetworkImage("${place.imageUrl}"),
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width - 40.0,
                  height: 250.0,
                ),
              ),
              /*Image.asset(
                  NetworkImage(place.imageUrl),
                height: 250.0,
                width: MediaQuery.of(context).size.width - 40.0,
                fit: BoxFit.cover,
              ),*/
            ),
          );
        },
      ),
    );
  }

  /*Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Popup example'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Hello"),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }*/
}
