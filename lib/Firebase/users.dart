import 'package:firebase_auth/firebase_auth.dart';

class Users {
  final String userid;
  final String name;

  Users({
    this.userid,
    this.name,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      userid: json['userid'],
      name: json['name'],
    );
  }
}
