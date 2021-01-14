import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskarta/Firebase/projects.dart';
import 'package:taskarta/Firebase/users.dart';
import 'package:taskarta/projects/projectcard.dart';
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
    if (flag == true)
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
          .map((snapshot) => snapshot.docs
              .map((doc) => Users.fromJson(doc.data(), ref: doc.reference))
              .toList());
    else
      return _db.collection('user').snapshots().map((snapshot) => snapshot.docs
          .map((doc) => Users.fromJson(doc.data(), ref: doc.reference))
          .toList());
  }

  Stream<List<Projects>> getProjects() {
    return _db
        .collection('projects')
        .where("members",
            arrayContains: FirebaseFirestore.instance
                .collection('user')
                .doc(FirebaseAuth.instance.currentUser.uid))
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Projects.fromJson(doc.data())).toList());
  }

//Upsert
  Future<void> setEntry(dynamic entry, String collection) {
    var options = SetOptions(merge: true);
    if (collection == 'task')
      return _db
          .collection(collection)
          .doc(entry.id)
          .set(entry.toMap(), options);
    else if (collection == 'projects')
      return _db
          .collection(collection)
          .doc(entry.projectID)
          .set(entry.toMap(), options);
    else
      return _db
          .collection(collection)
          .doc(entry.userid)
          .set(entry.toMap(), options);
  }

  //Delete
  Future<void> removeEntry(String entryId, String collection) {
    return _db.collection(collection).doc(entryId).delete();
  }
}
