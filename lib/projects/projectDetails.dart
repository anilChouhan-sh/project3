import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskarta/Firebase/entryprovider.dart';
import 'package:taskarta/Firebase/projectProvider.dart';
import 'package:taskarta/mytask/By_me.dart';
import 'package:taskarta/mytask/To_me.dart';

class ProjectDetails extends StatefulWidget {
  @override
  _ProjectDetailsState createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  @override
  Widget build(BuildContext context) {
    final projectprovider = Provider.of<ProjectProvider>(context);
    final entryprovider = Provider.of<Entryprovider>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(CupertinoIcons.ellipsis_vertical),
              onPressed: () {},
            )
          ],
          automaticallyImplyLeading: false,
          title:
              Consumer<ProjectProvider>(builder: (context, entryProvider, _) {
            return Text('${projectprovider.currentProject.project_name} ');
          }),
          backgroundColor: Colors.teal[700],
          bottom: TabBar(
            tabs: [
              Tab(text: 'All Tasks'),
              Tab(text: 'Assigned To ME'),
              Tab(text: 'Assigned By ME'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            By_me(
              userid: entryprovider.currentUser.userid,
              name: entryprovider.currentUser.name,
            ),
            To_me(
                userid: 'fdg',
                name: 'fdg',
                condition: 'whom',
                collection: 'task'),
            To_me(
                userid: 'dfg',
                name: 'fdg',
                condition: 'userid',
                collection: 'task'),
          ],
        ),
      ),
    );
  }
}
