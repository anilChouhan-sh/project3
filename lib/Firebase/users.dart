import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Users {
  final String userid;
  final String name;
  final DocumentReference ref;

  Users({this.userid, this.name, this.ref});

  factory Users.fromJson(Map<String, dynamic> json, DocumentReference ref) {
    return Users(userid: json['userid'], name: json['name'], ref: ref);
  }
}
