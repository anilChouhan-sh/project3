import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskarta/Drawer/support.dart';
import 'package:taskarta/Drawer/Rep.dart';
import 'package:taskarta/Firebase/Providers/userProviders.dart';
import 'package:taskarta/Firebase/auth.dart';

import 'myprofile.dart';
import 'Rep.dart';

class DrawerScreen extends StatelessWidget {
  Auth auth = new Auth();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Consumer<UserProvider>(builder: (context, userProvider, _) {
              return GestureDetector(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(),
                    SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${userProvider.currentUser.name}',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Text(
                          '${userProvider.currentUser.email}',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
            decoration: BoxDecoration(
              color: Colors.teal[700],
            ),
          ),
          ListTile(
            leading: Icon(CupertinoIcons.profile_circled),
            title: Text('My Profile'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyProfile()));
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_phone),
            title: Text('My Contacts'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.feedback_rounded),
            title: Text('Feedback'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Report()));
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_support_outlined),
            title: Text('Support'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Support()));
            },
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: ListTile(
              leading: Icon(Icons.login_outlined),
              title: Text('Logout'),
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text("Are you sure you want to Logout"),
                        actions: <Widget>[
                          FlatButton(
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          FlatButton(
                            child: Text(
                              "Logout",
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () async {
                              await auth.signOut();
                              Navigator.pushNamed(context, '/');
                            },
                          ),
                        ],
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
