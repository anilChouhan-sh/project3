import 'dart:async';

import 'package:flutter/material.dart';
import 'package:taskarta/Firebase/projectProvider.dart';
import 'package:taskarta/mytask/task.dart';
import 'package:provider/provider.dart';
import 'package:taskarta/Create Task/createtask.dart';
import 'package:taskarta/Firebase/entryprovider.dart';
import 'package:taskarta/Firebase/entry.dart';

class By_me extends StatelessWidget {
  final userid, name;
  By_me({this.userid, this.name});

  Stream xyz(entryProvider) {
    entryProvider.changevalue = userid;
    entryProvider.changeflag = false;
    entryProvider.changecondition = 'userid';
    entryProvider.changecollection = 'task';
    return entryProvider.entries;
  }

  List tempL = new List();
  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<Entryprovider>(context);
    final projectProvider = Provider.of<ProjectProvider>(context);
    Stream y = xyz(entryProvider);

    // projectProvider.currentProject.tasks.forEach((z) async {
    //   print(z);
    //   Stream y = await z.snapshots().map((doc) => Entry.fromJson(doc.data()));
    //   y.listen((x) {
    //     tempL.add(x);
    //     print("inside stream ${x.title}");
    //   });
    // });
    // Stream xp = projectProvider.currentProject.tasks[0]
    //     .snapshots()
    //     .map((doc) => Entry.fromJson(doc.data()));
    // print(xp);
    // xp.listen((x) {
    //   tempL.add(x);
    //   print("inside stream ${x.title}");
    // });
    // print("is it empty $tempL");
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CreatTask(userid: userid, name: name)));
            }),
        body: Consumer<ProjectProvider>(
          builder: (context, projectProvider, _) => ListView.builder(
              padding: EdgeInsets.only(top: 15, bottom: 0, left: 20, right: 20),
              itemCount: projectProvider.curr_tasks?.length,
              itemBuilder: (context, index) {
                return Container(
                  child: InkWell(
                    highlightColor: Colors.teal[700],
                    onLongPress: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text(
                                  "Are you sure you want to delete task : -${projectProvider.curr_tasks[index].title}?"),
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
                                    "Delete",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    child: Task(
                      data: projectProvider.curr_tasks[index],
                      flag: true,
                    ),
                    onTap: () {
                      print(name);
                    },
                  ),
                );
              }),
        ));
  }
}
