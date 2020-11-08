import 'package:cloud_firestore/cloud_firestore.dart';

class PostsModel {
  // static const ID = "id";
  static const NAME = "name";
  static const IMAGEURL = "imageUrl";
  static const DESCRIPTION = "description";
  static const TITLE = "title";
  static const ADDRESS = "address";
  static const ROLE = "role";
  static const PINCODE = "pincode";

  // String _id;
  String _name;
  String _imageUrl;
  String _description;
  String _title;
  String _address;
  String _role;
  String _pincode;

  // String get id => _id;

  String get name => _name;

  String get description => _description;

  String get imageUrl => _imageUrl;

  String get title => _title;

  String get address => _address;

  String get role => _role;

  String get pincode => _pincode;

  PostsModel.fromSnapshot(DocumentSnapshot snapshot) {
    // _id = snapshot.data()[ID];
    _imageUrl = snapshot.data()[IMAGEURL];
    _description = snapshot.data()[DESCRIPTION];
    _name = snapshot.data()[NAME];
    _title = snapshot.data()[TITLE];
    _address = snapshot.data()[ADDRESS];
    _role = snapshot.data()[ROLE];
    _pincode = snapshot.data()[PINCODE];
  }
}
