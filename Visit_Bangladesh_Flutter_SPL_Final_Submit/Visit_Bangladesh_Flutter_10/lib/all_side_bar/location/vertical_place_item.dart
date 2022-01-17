import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:scroll_text/scroll_text.dart';
import 'package:visit_bangladesh/all_side_bar/location/details.dart';
import 'package:visit_bangladesh/all_side_bar/location/place_model.dart';
import 'package:visit_bangladesh/all_side_bar/sidebar/sidebar.dart';
import 'package:visit_bangladesh/authentication/components/form_vertical_spacing.dart';

class VerticalPlaceItem extends StatelessWidget {
  final PlaceModel place;

  VerticalPlaceItem({this.place});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        child: Container(
          width: MediaQuery.of(context).size.width - 60,
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
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(28)),
                        child: Image(
                          image: NetworkImage("${place.imageUrl}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.48,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          text: "${place.placeName}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff00052A),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      /*Container(
                        child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Icon(
                                  Icons.location_on,
                                  size: 22.0,
                                  color: Colors.blueGrey[300],
                                ),
                              ),
                              TextSpan(
                                text: "  ${place["location"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  //fontWeight: FontWeight.bold,
                                  color: Color(0xff00052A),
                                ),
                                children: <TextSpan>[],
                              ),
                            ],
                          ),
                        ),
                      ),
                      ),*/
                      RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.location_on,
                                size: 22.0,
                                color: Colors.blueGrey[300],
                              ),
                            ),
                            TextSpan(
                              text: "   " +
                                  "${place.Division}" +
                                  ", " +
                                  "${place.District}",
                              style: TextStyle(
                                fontSize: 14,
                                //fontWeight: FontWeight.bold,
                                color: Color(0xff00052A),
                              ),
                              children: <TextSpan>[],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FormVerticalSpace(),
                          Text('Creator ' + ':  ' + "${place.creatorName}",
                              style: TextStyle(fontSize: 16)),
                          FormVerticalSpace(),
                          /*Text(labels.home.adminUserLabel + ': ' + _admin,
                      style: TextStyle(fontSize: 16)),*/
                        ],
                      )

                      /* RichText(
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
                              "${place["location"]}",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff949AA8)),
                            ),
                          ],
                        ),
                      ),*/
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return Details(place: place);
              },
            ),
          );
        },
      ),
    );
  }
}
