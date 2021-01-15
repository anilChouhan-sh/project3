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
  List<Users> _userContacts;
//getter
  String get name => _name;
  String get userid => _userid;
  String get email => _email;
  String get phone => _phone;

  List<dynamic> get username => _username;
  List<dynamic> get contacts => _contacts;
  List<Users> get userContacts => _userContacts;
  bool get userflag => _userflag;
  Stream<List<Users>> get users => firestore.getUsers(username, userflag);
  Users get currentUser => _currentUser;
//setter

  set changeUserContacts(List<Users> name) {
    _userContacts = name;
    notifyListeners();
  }

  set changeCurrentUser(Users name) {
    _currentUser = name;
    notifyListeners();
  }

  set changeuserflag(bool value) {
    _userflag = value;
    notifyListeners();
  }

  set changename(String value) {
    _name = value;
    notifyListeners();
  }

  set changeuserid(String value) {
    _userid = value;
    notifyListeners();
  }

  set changeemail(String value) {
    _email = value;
    notifyListeners();
  }

  set changephone(String value) {
    _phone = value;
    notifyListeners();
  }

  set changeusername(List<dynamic> username) {
    _username = username;
    notifyListeners();
  }

  set changecontacts(List<dynamic> contacts) {
    _contacts = contacts;
    notifyListeners();
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

class ContactsProvider with ChangeNotifier {
  List<Users> get usercontacts => _usercontacts;
  List<Users> _usercontacts = [];

  set changeusercontacts(List st) {
    _usercontacts?.clear();

    print('insidepro $st');
    st?.forEach((z) {
      print(z);
      Stream y = z.snapshots().map((doc) => Users.fromJson(doc.data()));
      y.listen((x) {
        int index = _usercontacts?.indexWhere((t) {
          return t.email == x.email;
        });

        if (index == -1) {
          _usercontacts.add(x);
        } else {
          _usercontacts[index] = x;
          print('dsfllksgjlkfdg');
        }
        print(_usercontacts);
        notifyListeners();
        print("inside stream ${x.email}");
      });
    });

    // print('insidess $_curr_tasks');
    //_curr_tasks = tempL;
    print('insidess $_usercontacts');
  }
}
