import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:taskarta/Firebase/entry.dart';
import 'package:taskarta/Firebase/firestore.dart';
import 'package:taskarta/Firebase/projects.dart';
import 'package:taskarta/projects/project.dart';
import 'package:uuid/uuid.dart';

class ProjectProvider with ChangeNotifier {
  final firestore_ser = Firestore_ser();
  var uuid = Uuid();
  String _mem;
  DocumentReference _created_by;
  String _project_name;
  String _start_date;
  dynamic _members;
  dynamic _tasks;
  String _projectID;
  Projects _currentProject;
  List<Entry> _curr_tasks;

  //getters
  List<Entry> get curr_tasks => _curr_tasks;
  String get mem => _mem;
  String get projectID => _projectID;
  String get start_date => _start_date;
  DocumentReference get created_by => _created_by;
  String get project_name => _project_name;
  dynamic get tasks => _tasks;
  dynamic get members => _members;
  Projects get currentProject => _currentProject;
  List<Entry> tempL = new List<Entry>();
  Stream<List<Projects>> get projects => firestore_ser.getProjects();

//setters
  set changeNum(String p) {
    _mem = p;
    notifyListeners();
  }

  set changecurr_tasks(List st) {
    print('insidepro $st');
    // st.forEach((z) {
    //   print("tp");
    //   Stream y = z.snapshots().map((doc) {
    //     Entry temp = Entry.fromJson(doc.data());
    //     tempL.add(temp);
    //     print('inside ');
    //     return temp;
    //   });
    // });
    print('insidess $tempL');
    _curr_tasks = tempL;
    notifyListeners();
  }

  set changeProject_name(String name) {
    _project_name = name;
    notifyListeners();
  }

  set changeProjectID(String name) {
    _projectID = name;
    notifyListeners();
  }

  set changeStart_date(String name) {
    _start_date = name;
    notifyListeners();
  }

  set changeMembers(dynamic name) {
    _members = name;
    notifyListeners();
  }

  set changetasks(dynamic name) {
    _tasks = name;
    notifyListeners();
  }

  set changeCreated_by(DocumentReference name) {
    _created_by = name;
    notifyListeners();
  }

  set changecurrentProject(Projects name) {
    _currentProject = name;
    notifyListeners();
  }

  saveEntry() {
    if (_projectID == null) {
      //Add
      var newEntry = Projects(
          project_name: _project_name,
          start_date: _start_date,
          created_by: _created_by,
          members: _members,
          tasks: _tasks,
          projectID: uuid.v1());

      firestore_ser.setEntry(newEntry, 'projects');
    } else {
      //Edit
      var updatedEntry = Projects(
          project_name: _project_name,
          start_date: _start_date,
          created_by: _created_by,
          members: _members,
          tasks: _tasks,
          projectID: _projectID);
      firestore_ser.setEntry(updatedEntry, 'projects');
    }
  }
}
