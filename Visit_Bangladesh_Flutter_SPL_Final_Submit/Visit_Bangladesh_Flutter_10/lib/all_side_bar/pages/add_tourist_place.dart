import 'dart:ui';

import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:visit_bangladesh/all_side_bar/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:visit_bangladesh/all_side_bar/pages/my_map.dart';
import 'package:visit_bangladesh/all_side_bar/pages/add_image.dart';
import 'package:visit_bangladesh/all_side_bar/sidebar/sidebar.dart';
import 'package:visit_bangladesh/authentication/components/form_input_field_with_icon.dart';
import 'package:visit_bangladesh/authentication/components/form_vertical_spacing.dart';
import 'package:visit_bangladesh/authentication/components/label_button.dart';
import 'package:visit_bangladesh/authentication/components/loading_screen.dart';
import 'package:visit_bangladesh/authentication/components/logo_graphic_header.dart';
import 'package:visit_bangladesh/authentication/components/primary_button.dart';
import 'package:visit_bangladesh/authentication/landing_page.dart';
import 'package:visit_bangladesh/authentication/sign_in/validators.dart';
import 'package:visit_bangladesh/authentication/user_model.dart';
import 'package:visit_bangladesh/services/auth.dart';
import 'package:visit_bangladesh/services/myUserAuth.dart';
import '../../main.dart';
import 'add_tourist_place.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'add_image.dart';
import 'dart:convert';

class AddTouristPlace extends StatefulWidget with NavigationStates {

  static LatLng LATLNG_VALUE = null;

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<AddTouristPlace> {
  final _registerFormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final _wardNameTextController = TextEditingController();
  final _placeNameTextController = TextEditingController();
  final _placeDetailsTextController = TextEditingController();
  final _psNameDetailsTextController = TextEditingController();
  final _psNumberDetailsTextController = TextEditingController();
  final _psInchargeDetailsTextController = TextEditingController();
  final _busDetailsTextController = TextEditingController();
  final _trainDetailsTextController = TextEditingController();
  final _launchDetailsTextController = TextEditingController();
  final _guideNameTextController = TextEditingController();
  final _guideNumberTextController = TextEditingController();
  final _guideAddressTextController = TextEditingController();

  String _myDivision;
  String _myDistrict;
  String _myUpazilla;
  String get _wardName => _wardNameTextController.text;
  String get _placeName => _placeNameTextController.text;
  String get _placeDetails => _placeDetailsTextController.text;
  String get _psNameDetails => _psNameDetailsTextController.text;
  String get _psNumberDetails=>_psNumberDetailsTextController.text;
  String get _psInchargeDetails=>_psInchargeDetailsTextController.text;
  String get _busDetails => _busDetailsTextController.text;
  String get _trainDetails => _trainDetailsTextController.text;
  String get _launchDetails => _launchDetailsTextController.text;
  String get _guideName => _guideNameTextController.text;
  String get _guideNumber => _guideNumberTextController.text;
  String get _guideAddress => _guideAddressTextController.text;

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;
  bool valuefirst = false;
  bool valuesecond = false;

  void initState() {
    _getDivisionList();
    super.initState();
  }

  List divisionList;

  String divisionUrl = 'https://bdapis.herokuapp.com/api/v1.1/divisions';

  Future<String> _getDivisionList() async {
    _myDivision = null;
    var res = await http
        .get(Uri.parse(divisionUrl), headers: {"Accept": "application/json"});
    var data = json.decode(res.body);

//      print(data);
    setState(() {
      divisionList = data['data'];
    });
    return 'Success Division';
  }

  // Get State information by API
  List districtList;

  String districtUrl;

  Future<String> _getDistrictList() async {
    districtUrl =
        'https://bdapis.herokuapp.com/api/v1.1/division/' + _myDivision;
    var res1 = await http
        .get(Uri.parse(districtUrl), headers: {"Accept": "application/json"});
    var data = json.decode(res1.body);

    setState(() {
      districtList = data['data'];
    });

    return 'Success District';
  }

  List<dynamic> upazillaList;

  Future<String> _getUpazillaList() async {
    districtUrl =
        'https://bdapis.herokuapp.com/api/v1.1/division/' + _myDivision;
    var res2 = await http
        .get(Uri.parse(districtUrl), headers: {"Accept": "application/json"});
    var data = json.decode(res2.body);
    List<dynamic> district = data['data'];
    for (int i = 0; district.length > i; i++) {
      if (district[i]['_id'] == _myDistrict) {
        upazillaList = district[i]['upazilla'];
      }
    }

    setState(() {
      upazillaList = upazillaList;
    });
    return 'Success Upazilla';
  }

  String _uName = '';
  String _uid = '';
  /* Widget _getProfileInfo(BuildContext context) {
    return StreamBuilder<UserModel>(
      stream: MyUserAuth.getUserInfo(),
      builder: (context, snapshot) {
        if (snapshot!=null && !snapshot.hasError) {
          if (snapshot.connectionState == ConnectionState.active) {
            UserModel user = snapshot.data;
            if (user != null) {
              setState(() {
                _uid = user.uid;
                _uName = user.name;
              });
            }
          }
        }
        return SizedBox();
      },
    );
  }*/

  Widget build(BuildContext context) {
    bool _loading = false;

    _uName = SideBarState.name;
    _uid = SideBarState.uid;
    print(SideBarState.name);
    print("////////////////////////////////////////////");

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("Add Tourist Places"), centerTitle: true,),
      body: LoadingScreen(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Text(
                        "Fill All The Information",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            decorationStyle: TextDecorationStyle.solid),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    /*SelectState(
                      onCountryChanged: (value) {
                        setState(() {
                          _myDivision = value;
                        });
                      },
                      onStateChanged: (value) {
                        setState(() {
                          _myDistrict = value;
                        });
                      },
                      onCityChanged: (value) {
                        setState(() {
                          _myUpazilla = value;
                        });
                      },
                    ),*/
                    Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                          color: Colors.blueGrey.shade100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: DropdownButton<String>(
                                      //onTap: _disposeall(),
                                      value: _myDivision,
                                      iconSize: 30,
                                      icon: (null),
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                      ),
                                      hint: Text('Select Division'),
                                      isExpanded: true,
                                      items: divisionList?.map((item) {
                                        return new DropdownMenuItem(
                                          child: new Text(item['division']),
                                          value: item['_id'].toString(),
                                        );
                                      })?.toList() ??
                                          [],
                                      onChanged: (String newValue) {
                                        setState(() {
                                          _myDistrict = null;
                                          districtList = null;
                                          _myUpazilla = null;
                                          upazillaList = null;
                                          _myDivision = newValue;
                                          _getDistrictList();
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                          color: Colors.blueGrey.shade100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: DropdownButton<String>(
                                      value: _myDistrict,
                                      iconSize: 30,
                                      icon: (null),
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                      ),
                                      hint: Text('Select District'),
                                      isExpanded: true,
                                      items: districtList?.map((item) {
                                        return new DropdownMenuItem(
                                          child: new Text(item['district']),
                                          value: item['_id'].toString(),
                                        );
                                      })?.toList() ??
                                          [],
                                      onChanged: (String newValue) {
                                        setState(() {
                                          _myUpazilla = null;
                                          upazillaList = null;
                                          _getUpazillaList();
                                          _myDistrict = newValue;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                          color: Colors.blueGrey.shade100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: DropdownButton<dynamic>(
                                      value: _myUpazilla,
                                      iconSize: 30,
                                      icon: (null),
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                      ),
                                      hint: Text('Select Upazilla'),
                                      onChanged: (newValue) {
                                        setState(() {
                                          _myUpazilla = newValue;
                                        });
                                      },
                                      items: upazillaList?.map((item) {
                                        return DropdownMenuItem(
                                          child: Text(item),
                                          value: item,
                                        );
                                      })?.toList() ??
                                          [],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Center(child: Text("OR", style: TextStyle(color: Colors.indigo),),),
                        SizedBox(height: 10,),
                        FormInputFieldWithIcon(
                          controller: _wardNameTextController,
                          iconPrefix: Icons.adjust_rounded,
                          labelText: "Enter CityCorporation Ward Name",
                          /*validator: (value) => Validator.validateEmail(
                        email: value,
                      ),*/
                          //keyboardType: TextInputType.emailAddress,
                          //maxLines: 15,
                          onChanged: (value) => null,
                          onSaved: (value) =>
                          _wardNameTextController.text = value,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    FormInputFieldWithIcon(
                      controller: _placeNameTextController,
                      iconPrefix: Icons.add_location_alt_outlined,
                      labelText: "Place Name",
                      /*validator: (value) => Validator.validateName(
                        name: value,
                      ),*/
                      onChanged: (value) => null,
                      onSaved: (value) => _placeNameTextController.text = value,
                    ),
                    FormVerticalSpace(),
                    FormInputFieldWithIcon(
                      controller: _placeDetailsTextController,
                      iconPrefix: Icons.adjust_rounded,
                      labelText: "Place Details",
                      /*validator: (value) => Validator.validateEmail(
                        email: value,
                      ),*/
                      //keyboardType: TextInputType.emailAddress,
                      //maxLines: 15,
                      onChanged: (value) => null,
                      onSaved: (value) =>
                      _placeDetailsTextController.text = value,
                    ),
                    FormVerticalSpace(),
                    /* FormInputFieldWithIcon(
                      controller: _psDetailsTextController,
                      iconPrefix: Icons.lock,
                      labelText: "Police Station Details",
                      *//*validator: (value) => Validator.validatePassword(
                        password: value,
                      ),*//*
                      //obscureText: true,
                      //maxLines: 1,
                      onChanged: (value) => null,
                      onSaved: (value) => _psDetailsTextController.text = value,
                    ),*/
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 10, 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Police Station Details',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          FormInputFieldWithIcon(
                            controller: _psNameDetailsTextController,
                            iconPrefix: Icons.local_police_rounded,
                            labelText: "Police Station Name",

                            /*validator: (value) => Validator.validateEmail(
                        email: value,
                      ),*/
                            //keyboardType: TextInputType.emailAddress,
                            //maxLines: 15,
                            onChanged: (value) => null,
                            onSaved: (value) =>
                            _psNameDetailsTextController.text = value,
                          ),
                          FormInputFieldWithIcon(
                            controller: _psNumberDetailsTextController,
                            iconPrefix: Icons.contact_phone_rounded,
                            labelText: "Phone Number",
                            /*validator: (value) => Validator.validateEmail(
                        email: value,
                      ),*/
                            //keyboardType: TextInputType.emailAddress,
                            //maxLines: 15,
                            onChanged: (value) => null,
                            onSaved: (value) =>
                            _psNumberDetailsTextController.text = value,
                          ),
                          FormInputFieldWithIcon(
                            controller: _psInchargeDetailsTextController,
                            iconPrefix: Icons.person,
                            labelText: "Incharge Name",
                            /*validator: (value) => Validator.validateEmail(
                        email: value,
                      ),*/
                            //keyboardType: TextInputType.emailAddress,
                            //maxLines: 15,
                            onChanged: (value) => null,
                            onSaved: (value) =>
                            _psInchargeDetailsTextController.text = value,
                          ),
                        ],
                      ),
                    ),
                    FormVerticalSpace(),
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 10, 10, 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Route',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              FormInputFieldWithIcon(
                                controller: _busDetailsTextController,
                                iconPrefix: Icons.directions_bus_rounded,
                                labelText: "Bus Details",

                                /*validator: (value) => Validator.validateEmail(
                        email: value,
                      ),*/
                                //keyboardType: TextInputType.emailAddress,
                                //maxLines: 15,
                                onChanged: (value) => null,
                                onSaved: (value) =>
                                _busDetailsTextController.text = value,
                              ),
                              FormInputFieldWithIcon(
                                controller: _trainDetailsTextController,
                                iconPrefix: Icons.train_rounded,
                                labelText: "Train Details",
                                /*validator: (value) => Validator.validateEmail(
                        email: value,
                      ),*/
                                //keyboardType: TextInputType.emailAddress,
                                //maxLines: 15,
                                onChanged: (value) => null,
                                onSaved: (value) =>
                                _trainDetailsTextController.text = value,
                              ),
                              FormInputFieldWithIcon(
                                controller: _launchDetailsTextController,
                                iconPrefix: Icons.directions_boat_filled_outlined,
                                labelText: "Lounge Details",
                                /*validator: (value) => Validator.validateEmail(
                        email: value,
                      ),*/
                                //keyboardType: TextInputType.emailAddress,
                                //maxLines: 15,
                                onChanged: (value) => null,
                                onSaved: (value) =>
                                _launchDetailsTextController.text = value,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 10, 10, 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Tour Guide Information',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              FormInputFieldWithIcon(
                                controller: _guideNameTextController,
                                iconPrefix: Icons.account_circle_rounded,
                                labelText: "Guide Name",

                                /*validator: (value) => Validator.validateEmail(
                        email: value,
                      ),*/
                                //keyboardType: TextInputType.emailAddress,
                                //maxLines: 15,
                                onChanged: (value) => null,
                                onSaved: (value) =>
                                _guideNameTextController.text = value,
                              ),
                              FormInputFieldWithIcon(
                                controller: _guideNumberTextController,
                                iconPrefix: Icons.contact_phone_rounded,
                                labelText: "Phone Number",
                                /*validator: (value) => Validator.validateEmail(
                        email: value,
                      ),*/
                                //keyboardType: TextInputType.emailAddress,
                                //maxLines: 15,
                                onChanged: (value) => null,
                                onSaved: (value) =>
                                _guideNumberTextController.text = value,
                              ),
                              FormInputFieldWithIcon(
                                controller: _guideAddressTextController,
                                iconPrefix: Icons.adjust_rounded,
                                labelText: "Guide Address",
                                /*validator: (value) => Validator.validateEmail(
                        email: value,
                      ),*/
                                //keyboardType: TextInputType.emailAddress,
                                //maxLines: 15,
                                onChanged: (value) => null,
                                onSaved: (value) =>
                                _guideAddressTextController.text = value,
                              ),
                            ],
                          ),
                        ),
                        /*Container(
                          margin: EdgeInsets.fromLTRB(20, 10, 10, 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Tour Guide Information',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              FormInputFieldWithIcon(
                                controller: _guideDetailsTextController,
                                iconPrefix: Icons.account_circle_rounded,
                                labelText: "Guide details",
                                maxLines: 25,
                                onChanged: (value) => null,
                                onSaved: (value) =>
                                _guideDetailsTextController.text = value,
                              ),
                            ],
                          ),
                        ),*/
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 10, 10, 10),
                          child: Row(
                            children: <Widget>[
                              SizedBox.fromSize(
                                size: Size(100, 80), // button width and height
                                child: ClipRect(
                                  child: Material(
                                    color: Colors.orange, // button color
                                    child: InkWell(
                                      splashColor: Colors.green, // splash color
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddImage()));
                                      }, // button pressed
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons.image_rounded), // icon
                                          Text("Upload"), // text
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 120,
                              ),
                              SizedBox.fromSize(
                                size: Size(100, 80), // button width and height
                                child: ClipRect(
                                  child: Material(
                                    color: Colors.orange, // button color
                                    child: InkWell(
                                      splashColor: Colors.green, // splash color
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => MyMap()));
                                      }, // button pressed
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons
                                              .edit_location_rounded), // icon
                                          Text("Google Maps"), // text
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    PrimaryButton(
                        labelText: "Save Info",
                        onPressed: () async {
                          //if (_formKey.currentState.validate()) {
                          SystemChannels.textInput.invokeMethod(
                              'TextInput.hide'); //to hide the keyboard - if any

                          //User user = await MyUserAuth.registerUsingEmailPassword(_name, _email, _password,);
                          if(_myUpazilla==null){
                            _myUpazilla = _wardName;
                          }
                          Future<String> placeN = MyUserAuth.inputPlaceDetails(
                              _myDivision,
                              _myDistrict,
                              _myUpazilla,
                              _placeName,
                              _placeDetails,
                              _psNameDetails,
                              _psNumberDetails,
                              _psInchargeDetails,
                              _busDetails,
                              _trainDetails,
                              _launchDetails,
                              _guideName,
                              _guideNumber,
                              _guideAddress,
                              _uid,
                              _uName,
                              AddTouristPlace.LATLNG_VALUE,
                              AddImage.imageURL
                          );

                          if (placeN == null) {
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text(" Try Again"),
                            ));
                          }
                          if (placeN != null) {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => SideBarLayout(),
                              ),
                              ModalRoute.withName('/'),
                            );
                          }
                          //}
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
        inAsyncCall: _loading,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
//print("Check-1111111  $res" );
