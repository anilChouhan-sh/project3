import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taskarta/Firebase/users.dart';
import 'package:uuid/uuid.dart';
import './entry.dart';

// ignore: camel_case_types
class Firestore_ser {
  /* String _condition;
  String _value;

  String get condition => _condition;
  String get value => _value;*/

  // var uuid = Uuid();
  FirebaseFirestore _db = FirebaseFirestore.instance;

  //get Entries

  Stream<List<Entry>> getEntries(
      String collection, String condition, String value, bool flag) {
    if (flag == false)
      return _db
          .collection(collection)
          .where(condition, isEqualTo: value)
          .snapshots()
          .map((snapshot) =>
              snapshot.docs.map((doc) => Entry.fromJson(doc.data())).toList());
    else
      return _db
          .collection(collection)
          .where(condition, arrayContains: value)
          .snapshots()
          .map((snapshot) =>
              snapshot.docs.map((doc) => Entry.fromJson(doc.data())).toList());
  }

  Stream<List<Users>> getUsers(List<dynamic> value, bool userflag) {
    if (userflag == false)
      return _db
          .collection('user')
          .where("userid", whereIn: value)
          .snapshots()
          .map((snapshot) =>
              snapshot.docs.map((doc) => Users.fromJson(doc.data())).toList());
    else
      return _db.collection('user').snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => Users.fromJson(doc.data())).toList());
  }

//Upsert
  Future<void> setEntry(Entry entry) {
    var options = SetOptions(merge: true);

    return _db.collection('task').doc(entry.id).set(entry.toMap(), options);
  }

  //Delete
  Future<void> removeEntry(String entryId) {
    return _db.collection('task').doc(entryId).delete();
  }
}
