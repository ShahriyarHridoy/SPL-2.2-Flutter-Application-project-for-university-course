import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:simple_gravatar/simple_gravatar.dart';
import 'package:visit_bangladesh/all_side_bar/location/place_model.dart';
import 'package:visit_bangladesh/authentication/user_model.dart';

class MyUserAuth {
  static final _firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  static User _userFromFirebase(User user) {
    print(user);
    if(user != null) print(user.uid);
    return user;
  }


  static Stream<User> authStateChanges() {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  /*static Stream<UserModel> userInfo(){
    return _db.collection('users').doc(User).snapshots().map((snapshots) => UserModel.fromMap(snapshots.data()));
  }*/


  static Future<User> currentUser() async {
    final user = _firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }


  static Future<User> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }


  static Future<User> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final authResult = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken),
        );

        /*Gravatar avatar = Gravatar(authResult.user.email);
        String avatarUrl = avatar.imageUrl(
          size: 200,
          defaultImage: GravatarImage.retro,
          rating: GravatarRating.pg,
          fileExtension: true,
        );*/
        //create the new user object
        UserModel _newUser = UserModel(
            uid: authResult.user.uid,
            email: authResult.user.email,
            name: authResult.user.displayName,
            photoUrl: authResult.user.photoURL);
        //update the user in firestore
        _updateUserFirestore(_newUser, authResult.user);
        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(
            code: 'MISSING_GOOGLE_AUTH_TOKEN',
            message: 'Missing Google Auth Token,');
      }
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign in abroted by user,');
    }
  }

  static Future<User> signInWithFacebook() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(
      ['public_profile'],
    );
    if (result.accessToken != null) {
      final authResult = await _firebaseAuth.signInWithCredential(
        FacebookAuthProvider.credential(result.accessToken.token),

      );
      return _userFromFirebase(authResult.user);
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }

  }

  static Future<User> signInWithEmailAndPassword(String email, String password) async {
    print('getting user from firebase');
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    print('now firebase user is $userCredential');
    return _userFromFirebase(userCredential.user);
  }

  static Future<User> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(userCredential.user);
  }

  static Future<User> registerUsingEmailPassword(
    String name,
    String email,
    String password,
  ) async {
    UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    /*Gravatar avatar = Gravatar(userCredential.user.email);
    String avatarUrl = avatar.imageUrl(
      size: 200,
      defaultImage: GravatarImage.retro,
      rating: GravatarRating.pg,
      fileExtension: true,
    );*/
    var gravatar = Gravatar(userCredential.user.email);
    //var url = gravatar.imageUrl();
    //create the new user object
    UserModel _newUser = UserModel(
        uid: userCredential.user.uid,
        email: userCredential.user.email,
        name: name,
        photoUrl: gravatar.imageUrl(),
    );
    //update the user in firestore
    _updateUserFirestore(_newUser, userCredential.user);
    return _userFromFirebase(userCredential.user);
  }

  //updates the firestore users collection
  static void _updateUserFirestore(UserModel user, User firebaseUser) {
    db
        .collection('users')
        .doc(firebaseUser.uid)
        .set(user.toJson(), SetOptions(merge: true));
  }

  static Stream<UserModel> streamFirestoreUser(User firebaseUser) {
    if (firebaseUser?.uid != null) {
      return db
          .collection('users')
          .doc(firebaseUser.uid)
          .snapshots()
          .map((snapshots) => UserModel.fromMap(snapshots.data()));
    }
    return null;
  }

  static Stream<UserModel> getUserInfo(){
    var firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser?.uid != null) {
      return db
          .collection('users')
          .doc(firebaseUser.uid)
          .snapshots()
          .map((snapshots) => UserModel.fromMap(snapshots.data()));
    }
    return null;
  }

  static Future<User> refreshUser(User user) async {
    //FirebaseAuth auth = FirebaseAuth.instance;

    await user.reload();
    Future<User> refreshedUser =  currentUser();

    return refreshedUser;
  }


   static Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    final facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    await _firebaseAuth.signOut();
  }

  static Future<String> inputPlaceDetails(
      String Division,
      String District,
      String Upazila,
      String placeName,
      String placeDetails,
      String psNameDetails,
      String psContactDetails,
      String psInchargeDetails,
      String busDetails,
      String trainDetails,
      String launchDetails,
      String guideName,
      String guideNumber,
      String guideAddress,
      String creatorId,
      String creatorName,
      LatLng latLng,
      var imgRef,
      ) async {
    print(
        ' check 2 - $Division, $District, $Upazila, $placeName, $placeDetails, $psNameDetails,$psContactDetails,$psInchargeDetails,$busDetails ,$trainDetails,$launchDetails,$guideName,$guideNumber,$guideAddress');
    //create the new user object
    PlaceModel _newPlace = PlaceModel(
      Division: Division,
      District: District,
      Upazila: Upazila,
      placeName: placeName,
      placeDetails: placeDetails,
      psNameDetails: psNameDetails,
      psContactDetails: psContactDetails,
      psInchargeDetails: psInchargeDetails,
      busDetails: busDetails,
      trainDetails: trainDetails,
      launchDetails: launchDetails,
      guideName: guideName,
      guideNumber: guideNumber,
      guideAddress: guideAddress,
      creatorId: creatorId,
      creatorName: creatorName,
      lat: latLng != null ? latLng.latitude : 0,
      lon: latLng != null ? latLng.longitude : 0,
      imageUrl: imgRef!=null? imgRef : '',
    );
    //update the user in firestore
    _updatePlaceFirestore(_newPlace, placeName);
    return placeName;
  }

  //updates the firestore users collection
  static void _updatePlaceFirestore(PlaceModel newPlace, String placeName) {
    db.collection('place_details').doc(placeName).set({
      'Division': [newPlace.Division],
      'District': [newPlace.District],
      'Upazila': [newPlace.Upazila],
      'Place Name': [newPlace.placeName],
      'Place Details': [newPlace.placeDetails],
      'lat': [newPlace.lat],
      'lon': [newPlace.lon],
      'url' : [newPlace.imageUrl],
      'Police Station Details': {
        'Station Name': [newPlace.psNameDetails],
        'Contact Number': [newPlace.psContactDetails],
        'Incharge Name': [
          newPlace.psInchargeDetails
        ] /*{'MoreStuff':[newPlace.planeDetails],'MoreStuff':[newPlace.launchDetails]*/
      },
      'Place Creator': {
        'creatorId': [newPlace.creatorId],
        'creatorName': [newPlace.creatorName],
         /*{'MoreStuff':[newPlace.planeDetails],'MoreStuff':[newPlace.launchDetails]*/
      },
      'Guide Details': {
        'Guide Name': [newPlace.guideName],
        'Guide Number': [newPlace.guideNumber],
        'Guide Address': [newPlace.guideAddress] /*{'MoreStuff':[newPlace.planeDetails],'MoreStuff':[newPlace.launchDetails]*/
      },
      'Route': {
        'Bus Details': [newPlace.busDetails],
        'Train Details': [newPlace.trainDetails],
        'Longue Details': [newPlace.launchDetails
        ] /*{'MoreStuff':[newPlace.planeDetails],'MoreStuff':[newPlace.launchDetails]*/
      },
    }, SetOptions(merge: true));
    print(
        ' check 3 - $newPlace.Division, $newPlace.District, $newPlace.Upazila, $newPlace.placeName, $newPlace.placeDetails, $newPlace.psNameDetails,$newPlace.psContactDetails,$newPlace.psInchargeDetails, $newPlace.busDetails, $newPlace.trainDetails,$newPlace.launchDetails,$newPlace.guideDetails');
  }
}
