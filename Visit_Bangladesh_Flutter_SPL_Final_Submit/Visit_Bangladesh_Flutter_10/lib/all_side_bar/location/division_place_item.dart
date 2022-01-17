import 'package:flutter/material.dart';
import 'package:visit_bangladesh/all_side_bar/location/details.dart';
import 'package:visit_bangladesh/all_side_bar/location/icon_badge.dart';
import 'package:visit_bangladesh/all_side_bar/location/place_model.dart';
import 'package:visit_bangladesh/all_side_bar/location/vertical_place_item.dart';
import 'package:visit_bangladesh/all_side_bar/pages/homepage.dart';
import 'package:visit_bangladesh/util/places.dart';

class DivisionPlaces extends StatelessWidget {
  final Map division;

  DivisionPlaces({this.division});
  //String divisionName= division["name"];
  //List divisionImg = division["img"];

  PlaceModel divPlaces;

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
        title: Text(
          "${division["name"]}",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
          maxLines: 2,
          textAlign: TextAlign.left,
        ),
        centerTitle: true,
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
            //padding: EdgeInsets.symmetric(horizontal: 10),
            primary: false,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${division["name"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.bookmark,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),*/
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20),
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
                        "${division["details"]}",
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

              SizedBox(height: 20),
              buildVerticalList(),
            ],
          ),
        ],
      ),
      /*floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.airplanemode_active,
        ),
        onPressed: () {},
      ),*/
    );
  }

  buildSlider() {
    print("${division["img"]}");
    print("1111111111111111111111111111");
    var divImgList= division["img"];
    return Container(
      padding: EdgeInsets.only(left: 20),
      height: 200.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        primary: false,
        itemCount: divImgList == null ? 0 : divImgList.length,
        itemBuilder: (BuildContext context, int index) {
          print("######################################################################");
          print('${divImgList.length}');
          var divisionImg = divImgList[index];
          print(divisionImg);

          return Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                "$divisionImg",
                height: 250.0,
                width: MediaQuery.of(context).size.width - 40.0,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  buildVerticalList() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: ListView.builder(
        primary: false,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: HomePage.placeModels == null ? 0 : HomePage.placeModels.length,
        itemBuilder: (BuildContext context, int index) {
          divPlaces = HomePage.placeModels[index];
          if(divPlaces.Division == division["id"]) {
            return VerticalPlaceItem(place: divPlaces);
          } else return Container();
        },
      ),
    );
  }
}

/*
class DivisionModel {
  String divisionName;
  String exitingPlaces;
  String divisionDetails;

  //PlaceModel({this.uid, this.email, this.name, this.photoUrl});
  DivisionModel({this.divisionName, this.exitingPlaces, this.divisionDetails});



  factory DivisionModel.fromMap(Map data) {
    return DivisionModel(
      divisionName: data['divisionName'] ?? '',
      exitingPlaces: data['exitingPlaces'] ?? '',
      divisionDetails: data['divisionDetails'] ?? '',
    );
  }

  Map<String, dynamic> toJson() =>
      {"divisionName":divisionName, "exitingPlaces":exitingPlaces, "divisionDetails": divisionDetails };


}*/
