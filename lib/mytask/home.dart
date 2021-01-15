import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:taskarta/Firebase/Providers/entryprovider.dart';
import 'package:taskarta/Firebase/Providers/userProviders.dart';

import 'package:taskarta/Firebase/auth.dart';
import 'package:taskarta/Firebase/entryprovider.dart';
import 'package:taskarta/mytask/task.dart';
import 'By_me.dart';
import 'To_me.dart';

class Mytask extends StatefulWidget {
  final userid, name;

  Mytask({this.userid, this.name});
  @override
  _State createState() => _State(userid, name);
}

class _State extends State<Mytask> {
  final String userid, name;
  _State(this.userid, this.name);
  Auth auth = new Auth();

  // not able to push
// help mee

  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<UserProvider>(context);
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await auth.signOut();
                Navigator.pushNamed(context, '/');
              },
            ),
            title: Consumer<UserProvider>(builder: (context, entryProvider, _) {
              return Text('${entryProvider.currentUser.name} \' s Tasks');
            }),
            backgroundColor: Colors.teal[700],
            bottom: TabBar(
              tabs: [
                Tab(text: 'Assigned To ME'),
                Tab(text: 'Assigned By ME'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              To_me(
                  userid: userid,
                  name: name,
                  condition: 'whom',
                  collection: 'task'),
              To_me(
                  userid: userid,
                  name: name,
                  condition: 'userid',
                  collection: 'task'),
            ],
          ),
        ),
      ),
    );
  }
}
