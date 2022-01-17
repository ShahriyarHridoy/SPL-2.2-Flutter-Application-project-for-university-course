//User Model
import 'package:visit_bangladesh/services/auth.dart';

class UserModel {
  String uid;
  String email;
  String name;
  String photoUrl;

  UserModel({this.uid, this.email, this.name, this.photoUrl});
  //UserModel.fromUser(User user): uid = user.uid;



  factory UserModel.fromMap(Map data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() =>
      {"uid": uid, "email": email, "name": name, "photoUrl": photoUrl};
}
