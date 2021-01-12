import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:taskarta/Firebase/firestore.dart';
import 'package:taskarta/Firebase/users.dart';
import 'package:taskarta/Firebase/users.dart';
import 'package:uuid/uuid.dart';
import './firestore.dart';
import './entry.dart';

class Entryprovider with ChangeNotifier {
  final firestore_ser = Firestore_ser();
  var _whom;
  String _title, _description, _date, _userid, _condition, _value, _collection;

  Users _currentUser;
  bool _done;
  String _id;
  List<dynamic> _username;
  var uuid = Uuid();

  bool _flag, _userflag;

  //getters
  String get title => _title;
  String get descrition => _description;
  String get whom => _whom;
  String get dateTime => _date;
  String get userid => _userid;
  String get value => _value;
  String get condition => _condition;
  String get collection => _collection;
  bool get done => _done;
  bool get flag => _flag;
  String get id => _id;
  Users get currentUser => _currentUser;
  List<dynamic> get username => _username;
  bool get userflag => _userflag;

  Stream<List<Entry>> get entries =>
      firestore_ser.getEntries(collection, condition, value, flag);

  Stream<List<Users>> get users => firestore_ser.getUsers(username, userflag);

  //Setters
  set changevalue(String value) {
    _value = value;
  }

  set changeuserflag(bool value) {
    _userflag = value;
  }

  set changeusername(List<dynamic> username) {
    _username = username;
  }

  set changeflag(bool flag) {
    _flag = flag;
  }

  set changecollection(String collection) {
    _collection = collection;
  }

  set changecondition(String condition) {
    _condition = condition;
  }

  set changeDate(String date) {
    _date = date;
    notifyListeners();
  }

  set changetitle(String title) {
    _title = title;
    notifyListeners();
  }

  set changedescription(String description) {
    _description = description;
    notifyListeners();
  }

  set changewhom(var whom) {
    _whom = whom;
    notifyListeners();
  }

  set changeid(String id) {
    _id = id;
    notifyListeners();
  }

  set changedone(bool done) {
    _done = done;
    notifyListeners();
  }

  set changeuserid(String userid) {
    _userid = userid;
    notifyListeners();
  }

  set changeCurrentUser(Users name) {
    _currentUser = name;
    notifyListeners();
  }

  //Functions
  loadAll(Entry entry) {
    if (entry != null) {
      _date = entry.date;
      _title = entry.title;
      _whom = entry.whom;
      _description = entry.description;
      _id = entry.id;
      _userid = entry.userid;
      _done = entry.done;
    } else {
      _date = null;
      _whom = null;
      _title = null;
      _description = null;
      _id = null;
      _userid = null;
      _done = null;
    }
  }

  saveEntry() {
    if (_id == null) {
      //Add
      var newEntry = Entry(
          date: _date,
          title: _title,
          id: uuid.v1(),
          description: _description,
          whom: _whom,
          userid: _userid,
          done: _done);
      print(newEntry.title);
      firestore_ser.setEntry(newEntry, 'task');
    } else {
      //Edit
      var updatedEntry = Entry(
          date: _date,
          title: _title,
          id: _id,
          description: _description,
          whom: _whom,
          userid: _userid,
          done: _done);
      firestore_ser.setEntry(updatedEntry, 'task');
    }
  }

  removeEntry(String entryId, String collection) {
    firestore_ser.removeEntry(entryId, collection);
  }
}
