import 'package:visit_bangladesh/services/auth.dart';

class PlaceModel {
  String Division;
  String District;
  String Upazila;
  String placeName;
  String placeDetails;
  String psNameDetails;
  String psContactDetails;
  String psInchargeDetails;
  String busDetails;
  String trainDetails;
  String launchDetails;
  String guideName;
  String guideNumber;
  String guideAddress;
  String creatorId;
  String creatorName;
  double lat;
  double lon;
  String imageUrl;

  //PlaceModel({this.uid, this.email, this.name, this.photoUrl});
  PlaceModel(
      {this.Division,
        this.District,
        this.Upazila,
        this.placeName,
        this.placeDetails,
        this.psNameDetails,
        this.psContactDetails,
        this.psInchargeDetails,
        this.busDetails,
        this.trainDetails,
        this.launchDetails,
        this.guideName,
        this.guideNumber,
        this.guideAddress,
        this.creatorId,
        this.creatorName,
        this.lat,
        this.lon,
        this.imageUrl});

  factory PlaceModel.fromMap(Map<String, dynamic> data) {

    String Division = data['Division'] == null? '' : data['Division'][0].toString();
    String District = data['District'] == null? '' :data['District'][0].toString();
    String Upazila = data['Upazila'] == null? '' :data['Upazila'][0].toString();
    String placeName = data['Place Name'] == null? '' :data['Place Name'][0].toString();
    String placeDetails = data['Place Details'] == null? '' :data['Place Details'][0].toString();
    String psNameDetails = data['Police Station Details']==null? '' : data['Police Station Details']['Station Name'] == null? '' :data['Police Station Details']['Station Name'][0].toString();
    String psContactDetails = data['Police Station Details']==null? '' :data['Police Station Details']['Contact Number'] == null? '' :data['Police Station Details']['Contact Number'][0].toString();
    String psInchargeDetails = data['Police Station Details']==null? '' :data['Police Station Details']['Incharge Name'] == null? '' :data['Police Station Details']['Incharge Name'][0].toString();
    String busDetails = data['Route']==null? '' : data['Route']['Bus Details'] == null? '' :data['Route']['Bus Details'][0].toString();
    String trainDetails = data['Route']==null? '' :data['Route']['Train Details'] == null? '' :data['Route']['Train Details'][0].toString();
    String launchDetails =data['Route']==null? '' : data['Route']['Longue Details'] == null? '' :data['Route']['Longue Details'][0].toString();
    String guideName = data['Guide Details']==null? '' : data['Guide Details']['Guide Name'] == null? '' :data['Guide Details']['Guide Name'][0].toString();
    String guideNumber = data['Guide Details']==null? '' : data['Guide Details']['Guide Number'] == null? '' :data['Guide Details']['Guide Number'][0].toString();
    String guideAddress = data['Guide Details']==null? '' : data['Guide Details']['Guide Address'] == null? '' :data['Guide Details']['Guide Address'][0].toString();
    String creatorId =data['Place Creator']==null? '' : data['Place Creator']['creatorId'] == null? '' :data['Place Creator']['creatorId'][0].toString();
    String creatorName =data['Place Creator']==null? '' : data['Place Creator']['creatorName'] == null? '' :data['Place Creator']['creatorName'][0].toString();
    double lat = data['lat'] == null? 0.0 :double.parse(data['lat'][0].toString());
    double lon = data['lon'] == null? 0.0 :double.parse(data['lon'][0].toString());
    String imageUrl = data['url'] == null? '' :data['url'][0].toString();


    return PlaceModel(
      Division: Division,
      District: District,
      imageUrl: imageUrl,
      lon: lon,
      lat: lat,
      creatorId: creatorId,
      creatorName: creatorName,
      guideName: guideName,
      guideNumber: guideNumber,
      guideAddress: guideAddress,
      busDetails: busDetails,
      launchDetails: launchDetails,
      trainDetails: trainDetails,
      placeDetails: placeDetails,
      placeName: placeName,
      psContactDetails: psContactDetails,
      psInchargeDetails: psInchargeDetails,
      psNameDetails: psNameDetails,
      Upazila: Upazila,
    );

  }

  Map<String, dynamic> toJson() => {
    "Division": Division,
    "District": District,
    "Upazila": Upazila,
    "placeName": placeName,
    "placeDetails": placeDetails,
    "psNameDetails": psNameDetails,
    "psContactDetails": psContactDetails,
    "psInchargeDetails": psInchargeDetails,
    "busDetails": busDetails,
    "planeDetails": trainDetails,
    "launchDetails": launchDetails,
    "guideName": guideName,
    "guideNumber": guideNumber,
    "guideAddress": guideAddress,
    "creatorId": creatorId,
    "creatorName": creatorName,
    "lat": lat,
    "lon": lon,
    "url": imageUrl,
  };
}
