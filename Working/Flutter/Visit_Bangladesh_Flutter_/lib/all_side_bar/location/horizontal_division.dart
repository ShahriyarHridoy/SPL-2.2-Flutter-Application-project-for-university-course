import 'package:flutter/material.dart';
import 'package:visit_bangladesh/all_side_bar/location/details.dart';
import 'package:visit_bangladesh/all_side_bar/location/division_place_item.dart';



class HorizontalDivision extends StatelessWidget {
  final Map division;

  HorizontalDivision({this.division});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only( right: 15.0, top: 15, bottom: 10),
      child: InkWell(
        child: Container(
          height: 250.0,
          width: 250.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[200],
                  blurRadius: 2,
                  spreadRadius: 1,
                  offset: Offset(0.0, 3)),
            ],
          ),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28.0),
                  topRight: Radius.circular(28.0),
                ),
                child: Image.asset(
                  "${division["imgCov"]}",
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(height: 5.0),
              Container(
                margin: const EdgeInsets.only( left: 15.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  "${division["name"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 3.0),
              Container(
                margin: const EdgeInsets.only( left: 15.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  "${division["exitingPlaces"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.0,
                    color: Colors.blueGrey[300],
                  ),
                  //maxLines: 1,
                  textAlign: TextAlign.left,
                ),
              ),
              //SizedBox(height: 3.0),
              /*Container(
                margin: const EdgeInsets.only( left: 15.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  "${division["Details"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    color: Colors.blueGrey[300],
                  ),
                  //maxLines: 1,
                  textAlign: TextAlign.left,
                ),
              ),*/
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return DivisionPlaces(division: division);
              },
            ),
          );
        },
      ),
    );
  }
}

/*class DivisionModel {
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
