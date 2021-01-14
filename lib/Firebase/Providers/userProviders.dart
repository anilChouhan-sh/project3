import 'package:flutter/cupertino.dart';

import 'package:taskarta/Firebase/firestore.dart';
import 'package:taskarta/Firebase/users.dart';

class UserProvider with ChangeNotifier {
  final firestore = Firestore_ser();

  Users _currentUser;
  bool _userflag;
  String _name;
  String _userid;
  String _email, _phone;

  List<dynamic> _username;
  List<dynamic> _contacts;
  List<Users> _usercontacts = [];
//getter
  String get name => _name;
  String get userid => _userid;
  String get email => _email;
  String get phone => _phone;

  List<dynamic> get username => _username;
  List<dynamic> get contacts => _contacts;
  List<Users> get usercontacts => _usercontacts;
  bool get userflag => _userflag;
  Stream<List<Users>> get users => firestore.getUsers(username, userflag);
  Users get currentUser => _currentUser;
//setter

  set changeusercontacts(List st) {
    _usercontacts?.clear();

    print('insidepro $st');
    st?.forEach((z) {
      print(z);
      Stream y = z.snapshots().map((doc) => Users.fromJson(doc.data()));
      y.listen((x) {
        int index = _usercontacts?.indexWhere((t) {
          return t?.email == x?.email;
        });

        if (index == -1) {
          _usercontacts.add(x);
          print("inside stream ${x.email}");
        } else {
          _usercontacts[index] = x;
          print('dsfllksgjlkfdg');
          notifyListeners();
        }
      });
    });

    // print('insidess $_curr_tasks');
    //_curr_tasks = tempL;
    print('insidess $_usercontacts');
  }

  set changeCurrentUser(Users name) {
    _currentUser = name;
  }

  set changeuserflag(bool value) {
    _userflag = value;
  }

  set changename(String value) {
    _name = value;
  }

  set changeuserid(String value) {
    _userid = value;
  }

  set changeemail(String value) {
    _email = value;
  }

  set changephone(String value) {
    _phone = value;
  }

  set changeusername(List<dynamic> username) {
    _username = username;
  }

  set changecontacts(List<dynamic> contacts) {
    _contacts = contacts;
  }

  loadAll(Users user) {
    if (user != null) {
      _contacts = user.contacts;
      _name = user.name;
      _email = user.email;
      _userid = user.userid;
      _phone = user.phone;
    } else {
      _email = null;
      _contacts = null;
      _name = null;
      _userid = null;
      _phone = null;
    }
  }

  saveUser() {
    //Edit
    var updatedUser = Users(
        contacts: _contacts,
        email: _email,
        name: _name,
        phone: _phone,
        userid: _userid);
    firestore.setEntry(updatedUser, 'user');
  }
}
