import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'add_tourist_place.dart';

class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  GoogleMapController mapController;
  final Set<Marker> _markers = {};

  void _onAddMarkerButtonPressed(LatLng latlang) {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(latlang.toString()),
        position: latlang,
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: TextField(
            decoration: InputDecoration(
                hintText: 'Search', prefixIcon: Icon(Icons.search)),
          ),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              //SearchMapPlaceWidget(
              // hasClearButton: true,
              // placeType: PlaceType.address,
              // placeholder: 'Enter your location',
              // apiKey: 'AIzaSyCnHbotR4pIYFwinOzJf4FHqjpTCkLXetQ',
              //onSelected: (Place place) async{
              //Geolocation geolocation = await place.geolocation;

              // ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: SizedBox(
                    height: 550,
                    child: GoogleMap(
                      onMapCreated: (GoogleMapController googlemapcontroller) {
                        setState(() {
                          mapController = googlemapcontroller;
                        });
                      },
                      initialCameraPosition: const CameraPosition(
                        zoom: 15.0,
                        target: LatLng(23.8103, 90.4125),
                      ),
                      onTap: (latlang) {
                        if (_markers.length >= 1) {
                          _markers.clear();
                        }
                        _onAddMarkerButtonPressed(latlang);
                        print(latlang);
                        AddTouristPlace.LATLNG_VALUE = latlang;
                      },
                      markers: _markers,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
