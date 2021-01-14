import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Users {
  final String userid;
  final String name, email, phone;
  final DocumentReference ref;
  List<dynamic> contacts;
  Users(
      {this.userid,
      this.name,
      this.ref,
      this.contacts,
      this.email,
      this.phone});

  factory Users.fromJson(Map<String, dynamic> json, {DocumentReference ref}) {
    return Users(
        userid: json['userid'],
        name: json['name'],
        ref: ref,
        contacts: json['contacts'],
        email: json['email'],
        phone: json['phone']);
  }

  Map<String, dynamic> toMap() {
    return {
      'userid': userid,
      'contacts': contacts,
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}
