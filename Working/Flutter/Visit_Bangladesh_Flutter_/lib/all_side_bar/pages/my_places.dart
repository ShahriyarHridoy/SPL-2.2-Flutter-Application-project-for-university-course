import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visit_bangladesh/all_side_bar/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:visit_bangladesh/all_side_bar/location/place_model.dart';
import 'package:visit_bangladesh/all_side_bar/location/vertical_place_item.dart';
import 'package:visit_bangladesh/all_side_bar/pages/myaccountspage.dart';
import 'package:visit_bangladesh/all_side_bar/sidebar/sidebar.dart';
import 'package:visit_bangladesh/authentication/user_model.dart';
import 'package:visit_bangladesh/services/myUserAuth.dart';

import 'homepage.dart';

class MyPlace  extends StatelessWidget with NavigationStates{
  PlaceModel place;



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
          "My Added Places",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
          maxLines: 2,
          textAlign: TextAlign.left,
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          primary: false,
          itemCount: HomePage.placeModels == null
              ? 0
              : HomePage.placeModels.length,
          itemBuilder: (BuildContext context, int index) {

            place = HomePage.placeModels[index];
            print("************************ Check ******************************");
            print(SideBarState.name);
            print(SideBarState.uid);
            print("************************ Check ******************************");
            if(SideBarState.uid == place.creatorId && SideBarState.name == place.creatorName && SideBarState.name != null){
            return VerticalPlaceItem(place: place);
            } else{
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
