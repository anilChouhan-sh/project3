import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:taskarta/Drawer/drawerscreen.dart';

import 'package:taskarta/mytask/home.dart';
import 'package:taskarta/projects/Homepage.dart';

class Bottom_nav extends StatefulWidget {
  final String name;
  Bottom_nav(this.name);

  @override
  _Bottom_navState createState() => _Bottom_navState();
}

class _Bottom_navState extends State<Bottom_nav> {
  List<Widget> _buildScreens() {
    return [
      Homepage(),
      Mytask(userid: FirebaseAuth.instance.currentUser.uid, name: widget.name),
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
    ];
  }

  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
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
