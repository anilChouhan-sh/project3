import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:taskarta/Firebase/firestore.dart';

import 'package:taskarta/models/Tasks.dart';

import 'package:uuid/uuid.dart';

import 'package:taskarta/Firebase/entry.dart';

class Entryprovider with ChangeNotifier {
  final firestore_ser = Firestore_ser();

  var _whom;
  String _title, _description, _date, _userid, _condition, _value, _collection;

  bool _done;
  String _id;

  var uuid = Uuid();

  bool _flag;

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

  Stream<List<Entry>> get entries =>
      firestore_ser.getEntries(collection, condition, value, flag);

  //Setters
  set changevalue(String value) {
    _value = value;
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

  Future<String> saveEntry() async {
    String id = uuid.v1();
    if (_id == null) {
      //Add
      var newEntry = Entry(
          date: _date,
          title: _title,
          id: id,
          description: _description,
          whom: _whom,
          userid: _userid,
          done: _done);
      print(newEntry.title);

      Tasks newTask = Tasks(
          date: _date,
          title: _title,
          id: id,
          desc: _description,
          whom: _whom,
          UserID: _userid,
          done: _done);
      await Amplify.DataStore.save(newTask);
      // firestore_ser.setEntry(newEntry, 'task');
      return id;
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
      //firestore_ser.setEntry(updatedEntry, 'task');
    }
    return "";
  }

  removeEntry(String entryId, String collection) {
    firestore_ser.removeEntry(entryId, collection);
  }
}
