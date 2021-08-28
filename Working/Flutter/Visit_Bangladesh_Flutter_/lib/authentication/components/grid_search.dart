import 'package:flutter/material.dart';
import 'package:visit_bangladesh/all_side_bar/location/details.dart';
import 'package:visit_bangladesh/all_side_bar/location/place_model.dart';
import 'package:visit_bangladesh/all_side_bar/pages/homepage.dart';
import 'package:visit_bangladesh/authentication/components/search_widget.dart';

class GridSearchScreen extends StatefulWidget {
  @override
  _GridSearchScreenState createState() => _GridSearchScreenState();
}

class _GridSearchScreenState extends State<GridSearchScreen> {
  List<PlaceModel> places ;
  List<PlaceModel> allPlaces = HomePage.placeModels;
  //List<Book> books;
  String query = '';

  @override
  void initState() {
    super.initState();

    places = allPlaces;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("Search Places"),
      centerTitle: true,
    ),
    body: Column(
      children: <Widget>[
        buildSearch(),
        Expanded(
          child: ListView.builder(
            itemCount: places.length,
            itemBuilder: (context, index) {
              final place = places[index];

              return buildBook(place);
            },
          ),
        ),
      ],
    ),
  );

  Widget buildSearch() => SearchWidget(
    text: query,
    hintText: 'Place or Location Name',
    onChanged: searchPlace,
  );

  Widget buildBook(PlaceModel place) {
    return ListTile(
      leading: Image.network(
        place.imageUrl,
        fit: BoxFit.cover,
        width: 50,
        height: 50,
      ),
      title: Text(place.placeName),
      subtitle: Text(place.Upazila + place.District ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return Details(place: place);
            },
          ),
        );
      }
    );
  }

  void searchPlace(String query) {
    final places = allPlaces.where((place) {
      final placeNameLower = place.placeName.toLowerCase();
      final districtLower = place.District.toLowerCase();
      final upazillaLower = place.Upazila.toLowerCase();
      final searchLower = query.toLowerCase();

      return placeNameLower.contains(searchLower) ||
          districtLower.contains(searchLower) || upazillaLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.places = places;
    });
  }
}
