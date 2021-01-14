import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:taskarta/Firebase/entry.dart';
import 'package:taskarta/Firebase/firestore.dart';
import 'package:taskarta/Firebase/projects.dart';
import 'package:taskarta/projects/projectcard.dart';
import 'package:uuid/uuid.dart';

import '../users.dart';

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
  List<Entry> _curr_tasks = [];
  List<Users> _promem = [];
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
  List<Users> get promem => _promem;
  Stream<List<Projects>> get projects => firestore_ser.getProjects();

//setters
  set changeNum(String p) {
    _mem = p;
    notifyListeners();
  }

  set changepromem(List st) {
    _promem?.clear();

    print('insidepro $st');
    st?.forEach((z) {
      print(z);
      Stream y = z.snapshots().map((doc) => Users.fromJson(doc.data()));
      y.listen((x) {
        int index = _promem?.indexWhere((t) {
          return t?.email == x?.email;
        });

        if (index == -1) {
          _promem.add(x);
          print("inside stream ${x.email}");
        } else {
          _promem[index] = x;
          print('dsfllksgjlkfdg');
        }
        notifyListeners();
      });
    });
  }

  set changecurr_tasks(List st) {
    _curr_tasks?.clear();

    print('insidepro $st');
    st.forEach((z) {
      print(z);
      Stream y = z.snapshots().map((doc) => Entry.fromJson(doc.data()));

      y.listen((x) {
        int index = _curr_tasks.indexWhere((t) {
          return t.title == x.title;
        });

        if (index == -1) {
          _curr_tasks.add(x);
        } else {
          _curr_tasks[index] = x;
        }
        print("inside stream ${x.title}");
        notifyListeners();
      });
    });
    // print('insidess $_curr_tasks');
    //_curr_tasks = tempL;
    print('insidess $_curr_tasks');
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

  loadAll(Projects entry) {
    if (entry != null) {
      _created_by = entry.created_by;
      _projectID = entry.projectID;
      _members = entry.members;
      _project_name = entry.project_name;
      _start_date = entry.start_date;
      _tasks = entry.tasks;
    } else {
      _created_by = null;
      _projectID = null;
      _members = null;
      _project_name = null;
      _start_date = null;
      _tasks = null;
    }
  }

  saveProject() {
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

  deleteProject(String id, String collection) {
    firestore_ser.removeEntry(id, collection);
  }
}
