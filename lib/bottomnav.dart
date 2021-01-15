import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:taskarta/Drawer/drawerscreen.dart';
import 'package:taskarta/Drawer/myprofile.dart';
import 'package:taskarta/Firebase/Providers/userProviders.dart';
import 'package:taskarta/Firebase/auth.dart';

import 'package:taskarta/contacts/button.dart';
import 'package:taskarta/contacts/contacts.dart';

import 'package:taskarta/mytask/home.dart';
import 'package:taskarta/projects/Homepage.dart';

class Bottom_nav extends StatefulWidget {
  final String name;
  Bottom_nav(this.name);

  @override
  _Bottom_navState createState() => _Bottom_navState();
}

class _Bottom_navState extends State<Bottom_nav> {
  PersistentTabController _controller;
  bool _hideNavBar;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
  }

  List<Widget> _buildScreens() {
    return [
      Homepage(),
      Mytask(userid: FirebaseAuth.instance.currentUser.uid, name: widget.name),
      MyContacts()
    ];
  }

  BuildContext testContext;
  List<BottomNavigationBarItem> _items() {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.table_badge_more), label: 'MyTasks'),
      BottomNavigationBarItem(
          icon: Icon(Icons.import_contacts), label: 'MyContacts')
    ];
  }

  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        return;
      },
      child: Scaffold(
        drawer: Drawer(
          child: DrawerScreen(),
        ),
        body: _buildScreens()[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: _items(),
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          currentIndex: _currentIndex,
          selectedItemColor: Colors.teal[700],
        ),
      ),
    );
  }
}
